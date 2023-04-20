#!/bin/bash

if test -e ~/.config/VSCodium/User/settings.json; then
  jq -s '.[0] * .[1]' ~/.config/VSCodium/User/settings.json ~/.local/share/chezmoi/dot_config/VSCodium/User/settings.json > ~/.config/VSCodium/User/settings.json.tmp && mv ~/.config/VSCodium/User/settings.json.tmp ~/.config/VSCodium/User/settings.json
else
  cp ~/.local/share/chezmoi/dot_config/VSCodium/User/settings.json ~/.config/VSCodium/User/settings.json
fi
