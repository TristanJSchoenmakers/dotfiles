#!/bin/bash
# -*- ENCODING: UTF-8 -*-

nix-shell -p git
git clone https://github.com/TristanJSchoenmakers/dotfiles.git
mv $HOME/.config $HOME/.config-old && mv dotfiles $HOME/.config
sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration-old.nix
sudo ln -s $HOME/.config/nix/configuration.nix /etc/nixos/configuration.nix
