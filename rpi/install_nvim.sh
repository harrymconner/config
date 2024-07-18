#!/bin/bash

sudo apt update && sudo apt upgrade

# these are the dependencies for nvim and kickstart
sudo apt install ninja-build gettext cmake unzip curl build-essential make gcc ripgrep xclip

git clone https://github.com/neovim/neovim && cd neovim && git checkout stable
make CMAKE_BUILD_TYPE=Release
cd build
cpack -G DEB && sudo dpkg -i nvim-linux64.deb
cd ../..
rm -rf neovim

git clone https://github.com/harrymconner/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

