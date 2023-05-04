#!/bin/bash

# Get the absolute path of the current user's home directory
USER_HOME_DIR=$(eval echo ~$(whoami))

# Kill lyricstify desktop mode if already running
pkill -f "tilda -g $USER_HOME_DIR/.config/tilda/lyricstify_desktop"

# Kill normal conky clock if already running
pkill -f "conky -c $USER_HOME_DIR/.config/conky/conky_normal.conf"

# Define the command with options to search for
lyricstify_command="tilda -g $USER_HOME_DIR/.config/tilda/lyricstify_panel"

# Check if the process is running
if pgrep -f "$lyricstify_command" > /dev/null
then
  # Disable extension to show center panel background 
  gnome-extensions disable executor@raujonas.github.io

  # If the process is running, kill it
  pkill -f "$lyricstify_command"
else
  # Change wallpaper
  dconf dump /org/gnome/desktop/background/ | sed "s|picture-uri='[^']*'|picture-uri='file://$USER_HOME_DIR/.wallpapers/hifumi_togo.png'|g" | sed "s|picture-uri-dark='[^']*'|picture-uri-dark='file://$USER_HOME_DIR/.wallpapers/hifumi_togo.png'|g" | dconf load /org/gnome/desktop/background/

  # Change GNOME shell theme
  dconf dump /org/gnome/shell/extensions/user-theme/ | sed "s|name='[^']*'|name='Nordic-persona-5-transparent-center-panel'|g" | dconf load /org/gnome/shell/extensions/user-theme/

  # If the process is not running, start it
  $lyricstify_command &

  # Enable extension to show center panel background 
  gnome-extensions enable executor@raujonas.github.io

  # Start conky
  conky -d -c $USER_HOME_DIR/.config/conky/conky_rotated.conf &

  # Send desktop notification if notify-send is installed
  if [ -x "$(which notify-send)" ]; then
    notify-send "Morgana" "You switched to 2nd desktop mode\\!" --icon ~/.wallpapers/morgana_icon.png --expire-time=5000
  fi
fi
