# Restore Arxiu
backup restore arxiu --dry-run
#backup restore arxiu
cp /Volumes/Backup/albert/Pictures/Bombillos.png $HOME/Pictures
# Restore zsh history
cp /Volumes/Backup/albert/.zsh_history $HOME/dotfiles/zsh/
# Review Downloads
rsync -a /Volumes/Backup/albert/Downloads/ /Users/albert/Downloads
# Review Desktop
rsync -a /Volumes/Backup/albert/Desktop/ /Users/albert/Desktop
# Libation: install from https://github.com/rmcrackan/Libation/blob/master/Documentation/InstallOnMac.md
rsync -a  /Volumes/Backup/albert/Libation/ /Users/albert/Libation

# Apps
prefs=(
    "calibre"
    "com.googlecode.iterm2.plist"
    "com.knollsoft.Rectangle.plist"
    "eu.exelban.Stats.plist"
    "com.microsoft.VSCode.plist"
    "org.libation.macos.plist"
)
for file in $prefs; do
  cp -r "/Volumes/Backup/albert/Library/Preferences/$file" "$HOME/Library/Preferences/"
done
