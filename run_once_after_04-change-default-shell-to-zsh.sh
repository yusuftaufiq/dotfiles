#!/bin/bash

echo "Do you want to change your default shell to zsh? (Y/N)"
read answer

if [[ "$answer" == "Y" || "$answer" == "y" ]]; then
  chsh -s $(which zsh)
fi
