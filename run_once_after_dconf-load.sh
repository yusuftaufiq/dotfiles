#!/bin/bash

configs=( $(find "$(dirname "$0")/gnome" -type f) )

for config in "${configs[@]}"; do
  path="${config%.ini}"
  dconf load "/org/$path/" < $config
done
