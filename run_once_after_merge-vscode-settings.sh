#!/bin/bash

if command -v code >/dev/null 2>&1; then
  jq -s '.[0] * .[1]' ~/.config/Code/User/settings.json dot_config/Code/User/settings.json > ~/.config/Code/User/settings.json
fi
