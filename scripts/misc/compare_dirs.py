# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "typer",
# ]
# ///

import os
import hashlib
import typer
import concurrent.futures
import fnmatch
from pathlib import Path
from collections import defaultdict
from typing import Optional, List
from enum import Enum

class ComparisonMethod(str, Enum):
    HASH = "hash"  # Full file hash (slowest, most accurate)
    HYBRID = "hybrid"  # Size + partial content (good balance)
    SIZE = "size"  # File size only (fastest, least accurate)
    SIZE_HEADER = "size_header"  # Size + first few KB (fast, reasonably accurate)

def should_exclude(path: Path, exclude_patterns: List[str], skip_hidden: bool) -> bool:
    """
    Check if a path should be excluded based on patterns and hidden status.
    
    Args:
        path: The path to check
        exclude_patterns: List of glob patterns to exclude
        skip_hidden: Whether to skip hidden directories and files (starting with '.')
    
    Returns:
        True if the path should be excluded, False otherwise
    """
    # Check if the path or any parent is hidden
    if skip_hidden:
        for part in path.parts:
            if part.startswith('.'):
                return True
    
    # Check exclude patterns
    path_str = str(path)
    for pattern in exclude_patterns:
        if fnmatch.fnmatch(path_str, pattern):
            return True
    
    return False

def calculate_file_signature(
    file_path: Path, 
    method: ComparisonMethod = ComparisonMethod.HASH,
    algorithm: str = "sha256", 
    header_size: int = 4096
) -> tuple[Path, str, str | None]:
    """
    Calculate file signature based on the chosen comparison method.
    Returns (file_path, signature, error_message or None)
    """
    try:
        # Get basic file stats
        stats = os.stat(file_path)
        file_size = stats.st_size
        
        # For SIZE method, just return the size as a string
        if method == ComparisonMethod.SIZE:
            return (file_path, f"SIZE:{file_size}", None)
        
        # For SIZE_HEADER or HYBRID methods, get header
        if method in (ComparisonMethod.SIZE_HEADER, ComparisonMethod.HYBRID):
            try:
                with open(file_path, "rb") as f:
                    header = f.read(header_size)
                
                if method == ComparisonMethod.SIZE_HEADER:
                    # Use size + header hash
                    header_hash = hashlib.md5(header).hexdigest()
                    return (file_path, f"SH:{file_size}:{header_hash}", None)
                
                # For HYBRID, we determine if we need full hash based on file size
                # Small files (< 1MB) - just hash the whole file
                # Medium files (1MB - 10MB) - hash first and last 4KB
                # Large files (> 10MB) - hash first, middle and last 4KB
                if file_size < 1_048_576:  # Less than 1MB
                    # Fall through to full hash calculation
                    pass
                else:
                    fragments = [header]  # Start with header
                    
                    with open(file_path, "rb") as f:
                        # Get the last fragment
                        f.seek(-min(header_size, file_size), os.SEEK_END)
                        fragments.append(f.read(header_size))
                        
                        # For larger files, also get a middle fragment
                        if file_size > 10_485_760:  # > 10MB
                            f.seek(file_size // 2, os.SEEK_SET)
                            fragments.append(f.read(header_size))
                    
                    # Create a combined hash of all fragments
                    combined_hash = hashlib.md5(b''.join(fragments)).hexdigest()
                    return (file_path, f"FRAG:{file_size}:{combined_hash}", None)
            
            except Exception as e:
                # If any error occurs during fragment reading, fall back to full hash
                pass
        
        # Full hash calculation (HASH method or fallback)
        hash_obj = hashlib.new(algorithm)
        buffer_size = 65536
        
        with open(file_path, "rb") as f:
            # Read the file in chunks to handle large files efficiently
            buffer = f.read(buffer_size)
            while buffer:
                hash_obj.update(buffer)
                buffer = f.read(buffer_size)
        
        return (file_path, f"HASH:{hash_obj.hexdigest()}", None)
    
    except (PermissionError, OSError) as e:
        return (file_path, "", str(e))

def get_all_files(
    directory: Path, 
    exclude_patterns: List[str] = None, 
    skip_hidden: bool = False,
    verbose: bool = False
) -> list[Path]:
    """
    Get all file paths in a directory recursively, with exclusion support.
    
    Args:
        directory: Root directory to scan
        exclude_patterns: List of glob patterns to exclude
        skip_hidden: Whether to skip hidden directories and files
        verbose: Whether to print verbose information
    
    Returns:
        List of file paths
    """
    exclude_patterns = exclude_patterns or []
    all_files = []
    skipped_dirs = 0
    skipped_files = 0
    
    for root, dirs, files in os.walk(directory):
        root_path = Path(root)
        
        # Process directories (modify dirs in-place to control os.walk)
        i = 0
        while i < len(dirs):
            dir_path = root_path / dirs[i]
            if should_exclude(dir_path, exclude_patterns, skip_hidden):
                if verbose:
                    typer.echo(f"Skipping directory: {dir_path}")
                dirs.pop(i)
                skipped_dirs += 1
            else:
                i += 1
        
        # Process files
        for filename in files:
            file_path = root_path / filename
            if should_exclude(file_path, exclude_patterns, skip_hidden):
                if verbose:
                    typer.echo(f"Skipping file: {file_path}")
                skipped_files += 1
                continue
            
            all_files.append(file_path)
    
    if verbose and (skipped_dirs > 0 or skipped_files > 0):
        typer.echo(f"Skipped {skipped_dirs} directories and {skipped_files} files due to exclusion rules")
    
    return all_files

def get_directory_signatures(
    directory: Path, 
    method: ComparisonMethod,
    algorithm: str = "sha256", 
    verbose: bool = False,
    workers: int = 1,
    header_size: int = 4096,
    exclude_patterns: List[str] = None,
    skip_hidden: bool = False
) -> dict[str, list[Path]]:
    """
    Recursively gather file signatures for all files in the directory.
    Returns a dictionary mapping signatures to lists of file paths.
    """
    sig_to_paths = defaultdict(list)
    all_files = get_all_files(directory, exclude_patterns, skip_hidden, verbose)
    
    if verbose:
        typer.echo(f"Found {len(all_files)} files to process using {method} method")
    
    processed_count = 0
    failed_files = []
    
    # Process files in parallel if workers > 1
    if workers > 1:
        with concurrent.futures.ProcessPoolExecutor(max_workers=workers) as executor:
            futures = [
                executor.submit(
                    calculate_file_signature, 
                    file_path, 
                    method, 
                    algorithm, 
                    header_size
                ) 
                for file_path in all_files
            ]
            
            for future in concurrent.futures.as_completed(futures):
                processed_count += 1
                file_path, signature, error = future.result()
                
                if error is None and signature:  # Successful signature
                    sig_to_paths[signature].append(file_path.relative_to(directory))
                else:  # Error occurred
                    failed_files.append((file_path, error or "Empty signature"))
                
                if verbose and (processed_count % 100 == 0 or processed_count == len(all_files)):
                    typer.echo(f"Processed {processed_count}/{len(all_files)} files...")
    else:
        # Single-threaded processing
        for file_path in all_files:
            if verbose:
                typer.echo(f"Processing: {file_path}")
            
            _, signature, error = calculate_file_signature(file_path, method, algorithm, header_size)
            processed_count += 1
            
            if error is None and signature:
                sig_to_paths[signature].append(file_path.relative_to(directory))
            else:
                failed_files.append((file_path, error or "Empty signature"))
            
            if verbose and processed_count % 100 == 0:
                typer.echo(f"Processed {processed_count}/{len(all_files)} files...")
    
    # Report failures
    if failed_files:
        typer.echo(f"\nFailed to process {len(failed_files)} files:")
        for file_path, error in failed_files[:10]:  # Show first 10 failures
            typer.echo(f"  Error processing {file_path}: {error}", err=True)
        
        if len(failed_files) > 10:
            typer.echo(f"  ... and {len(failed_files) - 10} more failures")
    
    return sig_to_paths

def find_unique_files(
    dir1_signatures: dict[str, list[Path]], 
    dir2_signatures: dict[str, list[Path]]
) -> dict[str, list[Path]]:
    """
    Find files that exist in dir1 but not in dir2, based on signature.
    Returns a dictionary mapping signatures to lists of file paths from dir1.
    """
    unique_signatures = set(dir1_signatures.keys()) - set(dir2_signatures.keys())
    return {sig: dir1_signatures[sig] for sig in unique_signatures}

def output_results(
    unique_files: dict[str, list[Path]], 
    verbose: bool,
    method: ComparisonMethod
) -> None:
    """Format and output the results."""
    unique_sig_count = len(unique_files)
    unique_file_count = sum(len(paths) for paths in unique_files.values())
    
    typer.echo(f"\nResults:")
    typer.echo(f"Found {unique_file_count} files ({unique_sig_count} unique contents) in directory 1 that are not in directory 2:")
    typer.echo(f"(Comparison method: {method.value})")
    
    if unique_sig_count > 0:
        for sig, paths in sorted(unique_files.items()):
            method_prefix = sig.split(':', 1)[0]
            
            for path in sorted(paths):
                if verbose:
                    typer.echo(f"  {path} [{sig}]")
                else:
                    # Show a shortened version of the signature
                    if method_prefix == "SIZE":
                        short_sig = f"size:{sig.split(':', 1)[1]}"
                    elif method_prefix in ("SH", "FRAG"):
                        parts = sig.split(':')
                        short_sig = f"{method_prefix}:{parts[1]}:{parts[2][:8]}..."
                    else:  # HASH
                        short_sig = f"hash:{sig.split(':', 1)[1][:8]}..."
                    
                    typer.echo(f"  {path} [{short_sig}]")

def main(
    dir1: Path = typer.Argument(..., help="First directory path", exists=True, dir_okay=True, file_okay=False),
    dir2: Path = typer.Argument(..., help="Second directory path", exists=True, dir_okay=True, file_okay=False),
    method: ComparisonMethod = typer.Option(
        ComparisonMethod.HYBRID, 
        "--method", "-m", 
        help="Comparison method to use"
    ),
    algorithm: str = typer.Option(
        "sha256", 
        "--algorithm", "-a", 
        help="Hash algorithm to use for hash-based methods"
    ),
    verbose: bool = typer.Option(
        False, 
        "--verbose", "-v", 
        help="Show verbose output including all processed files"
    ),
    workers: int = typer.Option(
        1, 
        "--workers", "-w", 
        help="Number of worker processes for parallel processing (0 = auto)"
    ),
    output_file: Optional[Path] = typer.Option(
        None, 
        "--output", "-o", 
        help="Write results to a file instead of stdout"
    ),
    quick: bool = typer.Option(
        False, 
        "--quick", "-q", 
        help="Quick mode - stop processing second directory once matching files are found"
    ),
    header_size: int = typer.Option(
        4096,
        "--header-size",
        help="Size in bytes of header/footer to read for partial content methods"
    ),
    skip_hidden: bool = typer.Option(
        True,
        "--skip-hidden",
        help="Skip hidden files and directories (starting with a dot)"
    ),
    exclude: List[str] = typer.Option(
        [],
        "--exclude", "-e",
        help="Exclude patterns (glob format, can be specified multiple times)"
    )
) -> None:
    """
    Compare two directories recursively and report files that exist in the first directory but not in the second,
    based on chosen comparison method.
    
    Available methods:
    - hash: Full file hash (slowest, most accurate)
    - hybrid: Smart hybrid using size + partial content (good balance)
    - size_header: File size + first few KB (fast, reasonably accurate)
    - size: File size only (fastest, least accurate)
    
    Examples:
        python dircompare.py dir1 dir2 --method hybrid
        python dircompare.py dir1 dir2 --skip-hidden --exclude "*.tmp" --exclude "*/.git/*"
    """
    # Adjust workers count
    if workers <= 0:
        workers = os.cpu_count() or 1
    
    # Convert to absolute paths for consistent display
    dir1 = dir1.absolute()
    dir2 = dir2.absolute()
        
    typer.echo(f"Comparing directories:")
    typer.echo(f"  Directory 1: {dir1}")
    typer.echo(f"  Directory 2: {dir2}")
    typer.echo(f"Using comparison method: {method.value}")
    
    # Show exclusion settings
    if skip_hidden:
        typer.echo("Skipping hidden files and directories")
    if exclude:
        typer.echo(f"Excluding patterns: {', '.join(f'"{pattern}"' for pattern in exclude)}")
    
    if method in (ComparisonMethod.HASH, ComparisonMethod.HYBRID):
        typer.echo(f"Hash algorithm: {algorithm}")
    
    if workers > 1:
        typer.echo(f"Using {workers} worker processes")
    if quick:
        typer.echo("Running in quick mode - will stop processing directory 2 early when possible")
    
    # Process first directory
    typer.echo(f"\nProcessing files in directory 1...")
    dir1_signatures = get_directory_signatures(
        dir1, method, algorithm, verbose, workers, header_size,
        exclude, skip_hidden
    )
    dir1_file_count = sum(len(paths) for paths in dir1_signatures.values())
    dir1_sig_count = len(dir1_signatures)
    typer.echo(f"Processed {dir1_file_count} files with {dir1_sig_count} unique signatures.")
    
    if dir1_sig_count == 0:
        typer.echo("\nNo valid files found in directory 1. Nothing to compare.")
        return
    
    # Process second directory
    typer.echo(f"\nProcessing files in directory 2...")
    
    # In quick mode, we can stop processing directory 2 once we have matched all signatures from directory 1
    if quick:
        dir2_signatures = defaultdict(list)
        dir1_sig_set = set(dir1_signatures.keys())
        remaining_sigs = dir1_sig_set.copy()
        
        all_files = get_all_files(dir2, exclude, skip_hidden, verbose)
        processed_count = 0
        
        if verbose:
            typer.echo(f"Found {len(all_files)} files to process")
        
        # Process files one by one and stop early if all signatures are matched
        for file_path in all_files:
            if verbose:
                typer.echo(f"Processing: {file_path}")
            
            _, signature, error = calculate_file_signature(
                file_path, method, algorithm, header_size
            )
            processed_count += 1
            
            if error is None and signature:
                if signature in dir1_sig_set:
                    dir2_signatures[signature].append(file_path.relative_to(dir2))
                    
                    # Only remove from remaining_sigs if it's still there
                    if signature in remaining_sigs:
                        remaining_sigs.remove(signature)
                        
                        # If we've matched all signatures, we can stop
                        if not remaining_sigs:
                            if verbose:
                                typer.echo(f"All signatures from directory 1 have been matched. Stopping early.")
                            break
            
            if verbose and processed_count % 100 == 0:
                typer.echo(f"Processed {processed_count}/{len(all_files)} files... " +
                          f"({len(dir1_sig_set) - len(remaining_sigs)}/{len(dir1_sig_set)} signatures matched)")
        
        dir2_file_count = sum(len(paths) for paths in dir2_signatures.values())
        dir2_sig_count = len(dir2_signatures)
        typer.echo(f"Processed {processed_count} of {len(all_files)} files with {dir2_sig_count} matching unique signatures.")
    else:
        # Normal mode - process all files in directory 2
        dir2_signatures = get_directory_signatures(
            dir2, method, algorithm, verbose, workers, header_size,
            exclude, skip_hidden
        )
        dir2_file_count = sum(len(paths) for paths in dir2_signatures.values())
        dir2_sig_count = len(dir2_signatures)
        typer.echo(f"Processed {dir2_file_count} files with {dir2_sig_count} unique signatures.")
    
    # Find unique files
    unique_files = find_unique_files(dir1_signatures, dir2_signatures)
    
    # Output results
    output_results(unique_files, verbose, method)
    
    # If output file is specified, write results to file
    if output_file:
        with open(output_file, 'w') as f:
            unique_sig_count = len(unique_files)
            unique_file_count = sum(len(paths) for paths in unique_files.values())
            
            f.write(f"Results:\n")
            f.write(f"Found {unique_file_count} files ({unique_sig_count} unique contents) in directory 1 that are not in directory 2:\n")
            f.write(f"(Comparison method: {method.value})\n\n")
            
            if unique_sig_count > 0:
                for sig, paths in sorted(unique_files.items()):
                    for path in sorted(paths):
                        if verbose:
                            f.write(f"{path} [{sig}]\n")
                        else:
                            # Show shortened signature
                            method_prefix = sig.split(':', 1)[0]
                            if method_prefix == "SIZE":
                                short_sig = f"size:{sig.split(':', 1)[1]}"
                            elif method_prefix in ("SH", "FRAG"):
                                parts = sig.split(':')
                                short_sig = f"{method_prefix}:{parts[1]}:{parts[2][:8]}..."
                            else:  # HASH
                                short_sig = f"hash:{sig.split(':', 1)[1][:8]}..."
                                
                            f.write(f"{path} [{short_sig}]\n")
        
        typer.echo(f"\nResults written to: {output_file}")
    
    typer.echo("\nDone.")

if __name__ == "__main__":
    typer.run(main)