# Restore Arxiu
rsync -a /Volumes/Backup/albert/Arxiu /Users/albert --exclude 'Work/Archive/*' --exclude 'Personal/Archive/*' --progress
cp /Volumes/Backup/albert/Pictures/Bombillos.png $HOME/Pictures
# Restore zsh history
cp /Volumes/Backup/albert/.zsh_history $HOME/
# Review Downloads
rsync -a /Volumes/Backup/albert/Downloads/ /Users/albert/Downloads
# Review Desktop
rsync -a /Volumes/Backup/albert/Desktop/ /Users/albert/Desktop

# Apps
cp -r /Volumes/Backup/albert/Library/Preferences/calibre $HOME/Library/Preferences
cp /Volumes/Backup/albert/Library/Preferences/com.googlecode.iterm2.plist $HOME/Library/Preferences/
cp /Volumes/Backup/albert/Library/Preferences/net.elasticthreads.nv.plist $HOME/Library/Preferences/
cp /Volumes/Backup/albert/Library/Preferences/com.knollsoft.Rectangle.plist $HOME/Library/Preferences/
cp /Volumes/Backup/albert/Library/Preferences/eu.exelban.Stats.plist $HOME/Library/Preferences/
cp -r "/Volumes/Backup/albert/Library/Application Support/Notational Velocity" "$HOME/Library/Preferences/Application Support"
cp -r /Volumes/Backup/albert/.SoulseekQt $HOME/
cp -r "/Volumes/backup/albert/Documents/ScummVM Savegames" "$HOME/Documents/"
# Fix this in the future
mkdir -p $HOME/Library/Music/Scripts
cp -r "/Volumes/Backup/albert/Library/iTunes/Scripts/*" "$HOME/Library/Music/Scripts/"
