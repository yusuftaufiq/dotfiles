#!/bin/bash

# Get the absolute path of the current user's home directory
USER_HOME_DIR=$(eval echo ~$(whoami))

# Disable extension to show center panel background 
gnome-extensions disable executor@raujonas.github.io

# Kill lyricstify panel mode if already running
pkill -f "tilda -g $USER_HOME_DIR/.config/tilda/lyricstify_panel"

# Kill rotated conky clock if already running
pkill -f "conky -d -c $USER_HOME_DIR/.config/conky/conky_rotated.conf"

# Define the command with options to search for
lyricstify_command="tilda -g $USER_HOME_DIR/.config/tilda/lyricstify_desktop"

# Check if the process is running
if pgrep -f "$lyricstify_command" > /dev/null
then
  # If the process is running, kill it
  pkill -f "$lyricstify_command"
else
  # Change wallpaper
  dconf dump /org/gnome/desktop/background/ | sed "s|picture-uri='[^']*'|picture-uri='file://$USER_HOME_DIR/.wallpapers/kasumi_yoshizawa.png'|g" | sed "s|picture-uri-dark='[^']*'|picture-uri-dark='file://$USER_HOME_DIR/.wallpapers/kasumi_yoshizawa.png'|g" | dconf load /org/gnome/desktop/background/
  gsettings set org.gnome.desktop.background picture-uri "file://$USER_HOME_DIR/.wallpapers/kasumi_yoshizawa.png"

  # Change GNOME shell theme
  dconf dump /org/gnome/shell/extensions/user-theme/ | sed "s|name='[^']*'|name='Nordic-persona-5'|g" | dconf load /org/gnome/shell/extensions/user-theme/

  # If the process is not running, start it
  $lyricstify_command &

  # Start conky
  conky -d -c $USER_HOME_DIR/.config/conky/conky_normal.conf &

  # Send desktop notification if notify-send is installed
  if [ -x "$(which notify-send)" ]; then
    notify-send "Morgana" "You switched to 2nd desktop mode\\!" --icon ~/.wallpapers/morgana_icon.png --expire-time=5000
  fi
fi
