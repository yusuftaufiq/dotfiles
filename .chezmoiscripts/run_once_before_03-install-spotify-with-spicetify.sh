#!/bin/bash

if [ -x "$(which apt)" ]; then
  curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

  sudo apt update
  sudo apt install spotify-client
  sudo chmod a+wr /usr/share/spotify
  sudo chmod a+wr /usr/share/spotify/Apps -R

  export PATH=$PATH:~/.spicetify

  /usr/bin/spotify & sleep 5 && kill $(pgrep spotify)

  curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh

  spicetify backup apply
fi
