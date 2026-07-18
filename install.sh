#!/bin/bash
# -*- ENCODING: UTF-8 -*-

nix-shell -p git
git clone https://github.com/TristanJSchoenmakers/dotfiles.git
mv $HOME/.config $HOME/.config-old && mv dotfiles $HOME/.config

sudo nixos-rebuild switch --flake $HOME/.config/nix#nixos --impure
