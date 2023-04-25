#!/bin/bash

sudo apt update
sudo apt install \
  curl \
  wget \
  neofetch \
  zsh \
  tmux \
  tilda \
  cava \
  conky \
  git \
  fzf \
  bat \
  fd-find

cd ~

wget https://github.com/lsd-rs/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb
sudo dpkg -i lsd_0.23.1_amd64.deb
rm lsd_0.23.1_amd64.deb
