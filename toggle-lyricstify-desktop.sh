#!/bin/bash

# Get the absolute path of the current user's home directory
USER_HOME_DIR=$(eval echo ~$(whoami))

# Disable extension to show center panel background 
gnome-extensions disable executor@raujonas.github.io

# Kill lyricstify panel if already running
pkill -f "tilda -g $USER_HOME_DIR/.config/tilda/lyricstify_panel"

# Define the command with options to search for
command="tilda -g $USER_HOME_DIR/.config/tilda/lyricstify_desktop"

# Check if the process is running
if pgrep -f "$command" > /dev/null
then
  # If the process is running, kill it
  pkill -f "$command"
else
  # Change wallpaper
  dconf dump /org/gnome/desktop/background/ | sed "s|picture-uri='[^']*'|picture-uri='file://$USER_HOME_DIR/Pictures/Wallpapers/kasumi_yoshizawa.png'|g" | sed "s|picture-uri-dark='[^']*'|picture-uri-dark='file://$USER_HOME_DIR/Pictures/Wallpapers/kasumi_yoshizawa.png'|g" | dconf load /org/gnome/desktop/background/

  # Change GNOME shell theme
  dconf dump /org/gnome/shell/extensions/user-theme/ | sed "s|name='[^']*'|name='Nordic-persona-5'|g" | dconf load /org/gnome/shell/extensions/user-theme/

  # If the process is not running, start it
  $command &
fi
