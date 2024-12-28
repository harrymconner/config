#!/bin/bash

sudo apt-get update && sudo apt-get upgrade

# --- settings ---
cp ~/settings/.gitconfig ~/.gitconfig

# --- uv ---
curl -LsSf https://astral.sh/uv/install.sh | sh &&
source ~/.local/bin/env &&
uv python install

# --- docker ---
sudo apt-get install docker.io
sudo groupadd docker
sudo usermod -aG docker $USER

DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.32.1/docker-compose-linux-aarch64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

# --- neovim ---
# cd ~

# sudo apt-get update && sudo apt-get upgrade &&

# # these are the dependencies for nvim and kickstart
# sudo apt-get install ninja-build gettext cmake unzip curl build-essential make gcc ripgrep xclip

# git clone https://github.com/neovim/neovim && cd neovim && git checkout stable && /
# make CMAKE_BUILD_TYPE=Release && /
# cd build && /
# cpack -G DEB && sudo dpkg -i nvim-linux64.deb

# cd ~ && /
# sudo rm -rf neovim

# git clone https://github.com/harrymconner/kickstart.nvim.git "${XDG_CONFIG_HOME:-~/.config}"/nvim
# cd .config/nvim && /
# git pull
