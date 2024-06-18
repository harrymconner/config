#!/bin/bash

sudo apt update && sudo apt upgrade
sudo apt install git
git config --global user.name "Harry Conner"
git config --global user.email "harrymconner@gmail.com"
git config --global push.autosetupremote true
git config --global init.defaultBranch main
