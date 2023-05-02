#!/bin/bash

if [ -x "$(which apt)" ]; then
  sudo apt update
  sudo apt install gnome-tweaks gnome-shell-extensions python3 python3-pip
fi

export PATH=$PATH:~/.local/bin

if [ -x "$(which pip3)" ]; then
  pip3 install --upgrade gnome-extensions-cli

  gext install user-theme@gnome-shell-extensions.gcampax.github.com
  gext install widgets@aylur
  gext install rounded-window-corners@yilozt
  gext install unite@hardpixel.eu
  gext install dash-to-dock-cosmic-@halfmexicanhalfamazing@gmail.com
  gext install compiz-alike-magic-lamp-effect@hermes83.github.com
  gext install Move_Clock@rmy.pobox.com
  gext install executor@raujonas.github.io
  gext install arcmenu@arcmenu.com
fi
