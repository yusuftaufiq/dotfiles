#!/bin/bash

configs=( $(find ~/.local/share/chezmoi/gnome -type f) )

for config in "${configs[@]}"; do
  path="${config%.ini}"
  path="${path#~/.local/share/chezmoi/}"

  dconf load "/org/$path/" < $config
done
