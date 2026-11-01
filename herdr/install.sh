#!/bin/bash

set -euo pipefail

# Pinned versions. To bump one, change the version and both checksums (see README.md).
HERDR_VERSION="0.9.5"
HERDR_SHA256_X86_64="5fb0a908ec7f6745e3e245738b06bfad56c46391c391ab3c0955fbead01f1369"
HERDR_SHA256_AARCH64="fb77c2232a05a8035421382c894392f4174e4e38a18e48af3dd0290157c3a7e2"
COLLIE_VERSION="1.25.3"
COLLIE_SHA256_X64="fbd6dc07bb5166167a3b5028bac9cb671716faa96acd36f720d5738a180b88cb"
COLLIE_SHA256_ARM64="463aa8055d30e2274d221e417202e99f123a77de10c6e31170fb199e46ef695c"

herdr_binary="$HOME/.local/bin/herdr"
collie_dir="${COLLIE_DIR:-$HOME/.local/share/collie}"

usage() {
    echo "Usage: $0 [--help]"
    echo
    echo "Installs herdr, its Claude Code hook and Collie. Safe to re-run."
    echo "Does not start herdr or Collie."
}

for argument in "$@"; do
    case "$argument" in
        -h | --help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $argument" >&2
            usage >&2
            exit 2
            ;;
    esac
done

case "$(uname -m)" in
    x86_64)
        herdr_arch="x86_64"
        herdr_sha256="$HERDR_SHA256_X86_64"
        collie_arch="x64"
        collie_sha256="$COLLIE_SHA256_X64"
        ;;
    arm64)
        herdr_arch="aarch64"
        herdr_sha256="$HERDR_SHA256_AARCH64"
        collie_arch="arm64"
        collie_sha256="$COLLIE_SHA256_ARM64"
        ;;
    *)
        echo "Unsupported architecture: $(uname -m)." >&2
        exit 1
        ;;
esac

work_dir="$(mktemp -d)"
trap 'rm -rf "$work_dir"' EXIT

mkdir -p "$HOME/.local/bin"

# Download a file and check it against a pinned sha256 before anything uses it.
# Arguments: url, destination, expected checksum.
download_verified() {
    local url="$1" destination="$2" expected="$3" actual
    curl -fsSL -o "$destination" "$url"
    actual="$(shasum -a 256 "$destination" | awk '{print $1}')"
    if [[ "$actual" != "$expected" ]]; then
        echo "Checksum mismatch for $url" >&2
        echo "  expected $expected" >&2
        echo "  got      $actual" >&2
        exit 1
    fi
}

# Install herdr. herdr updates itself with `herdr update`, so an installed
# version at or above the pinned one is left alone; this never downgrades.
installed_herdr=""
if [[ -x "$herdr_binary" ]]; then
    installed_herdr="$("$herdr_binary" --version 2>/dev/null | awk '{print $2}' || true)"
fi
if [[ -n "$installed_herdr" ]] &&
    [[ "$(printf '%s\n%s\n' "$HERDR_VERSION" "$installed_herdr" | sort -V | tail -n 1)" == "$installed_herdr" ]]; then
    echo "herdr $installed_herdr is already installed (pinned $HERDR_VERSION), skipping download."
else
    download_verified \
        "https://github.com/herdrdev/herdr/releases/download/v${HERDR_VERSION}/herdr-macos-${herdr_arch}" \
        "$work_dir/herdr" "$herdr_sha256"
    chmod +x "$work_dir/herdr"
    mv "$work_dir/herdr" "$herdr_binary"
    echo "Installed herdr $HERDR_VERSION."
fi

# Installs a Claude Code hook so herdr can see agent state. Idempotent.
"$herdr_binary" integration install claude

# Install Collie with the same layout as its official installer. Collie updates
# itself with `collie update` and keeps its own rollback, so an existing
# install is never touched: reinstalling would fight it.
if [[ -d "$collie_dir/versions" ]]; then
    echo "Collie is already installed in $collie_dir, skipping (use 'collie update' to upgrade)."
elif [[ -e "$collie_dir" ]]; then
    echo "$collie_dir exists but has no versions/ directory. Move it aside and re-run." >&2
    exit 1
else
    collie_platform="macos-${collie_arch}"
    download_verified \
        "https://github.com/AltanS/collie/releases/download/v${COLLIE_VERSION}/collie-${COLLIE_VERSION}-${collie_platform}.tar.gz" \
        "$work_dir/collie.tar.gz" "$collie_sha256"
    tar -xzf "$work_dir/collie.tar.gz" -C "$work_dir"
    extracted="$work_dir/collie-${COLLIE_VERSION}-${collie_platform}"
    if [[ ! -x "$extracted/bin/collie" ]]; then
        echo "The Collie archive doesn't contain bin/collie." >&2
        exit 1
    fi
    mkdir -p "$collie_dir/versions"
    mv "$extracted" "$collie_dir/versions/$COLLIE_VERSION"
    ln -sfn "versions/$COLLIE_VERSION" "$collie_dir/current"
    "$collie_dir/versions/$COLLIE_VERSION/bin/collie" link
    echo "Installed Collie $COLLIE_VERSION."
fi

# Starting Collie and joining the crew are manual steps (see herdr/README.md).
echo
echo "Next steps, run by hand (details in herdr/README.md):"
echo "  1. Laptop: COLLIE_MUX=herdr collie start"
echo "  2. Laptop: ssh home '~/.local/bin/collie crew invite' | collie crew join https://server.tail8fef08.ts.net - --label dc10 --address <laptop-tailnet-name>:8787"
echo "  3. Laptop: set COLLIE_HOST=<tailscale ip -4> and COLLIE_ALLOW_NON_LOOPBACK_BIND=1 in the Collie .env, then collie restart"
echo "  4. Server: collie restart, then collie crew status (member shows link reachable)"
