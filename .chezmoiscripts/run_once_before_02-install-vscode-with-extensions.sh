#!/bin/bash

if [ -x "$(which apt)" ]; then
  sudo apt-get install wget gpg
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg

  sudo apt install apt-transport-https
  sudo apt update
  sudo apt install code
fi

if [ -x "$(which code)" ]; then
  code --install-extension arcticicestudio.nord-visual-studio-code
  code --install-extension monokai.theme-monokai-pro-vscode
  code --install-extension PKief.material-product-icons
fi
