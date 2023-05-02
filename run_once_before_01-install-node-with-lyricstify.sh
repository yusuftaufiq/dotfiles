#!/bin/bash

if [ -x "$(which apt)" ]; then
  curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash -
  sudo apt install nodejs
fi

if [ -x "$(which npm)" ]; then
  npm install -g @lyricstify/lyricstify --prefix ~/.npm-global
fi

