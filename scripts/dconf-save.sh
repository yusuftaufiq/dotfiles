#!/bin/bash

configs=(
  "gnome/shell/extensions/executor"
  "gnome/shell/extensions/aylurs-widgets" 
  "gnome/shell/extensions/rounded-window-corners"
  "gnome/shell/extensions/unite"
  "gnome/shell/extensions/dash-to-dock-pop"
  "gnome/shell/extensions/pop-shell"
  "gnome/shell/extensions/pop-cosmic"
  "gnome/shell/extensions/ncom/github/hermes83/compiz-alike-magic-lamp-effect"
  "gnome/shell/extensions/user-theme"
  "gnome/desktop/interface"
  "gnome/desktop/wm/keybindings"
  "gnome/desktop/wm/preferences"
  "gnome/gedit/preferences/editor"
  "gnome/mutter"
  "gnome/nautilus/icon-view"
  "gnome/nautilus/list-view"
  "gnome/nautilus/preferences"
  "gnome/shell/keybindings"
  "gnome/terminal"
)

for config in "${configs[@]}"; do
  mkdir -p "$(dirname "$config")"
  dconf dump "/org/$config/" > "$config.ini"
done
