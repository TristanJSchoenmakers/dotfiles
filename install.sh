#!/bin/bash
# -*- ENCODING: UTF-8 -*-
sudo pacman -Syu


#######################################
# 1 - Install packages
#######################################

# Program language build tools
sudo pacman -S --noconfirm dotnet-sdk dotnet-runtime rust

# IDE
sudo pacman -S --noconfirm neovim rust-analyzer

# Personal tools
sudo pacman -S --noconfirm discord qutebrowser

# Terminal
sudo pacman -S --noconfirm alacritty starship ttf-jetbrains-mono

# Tui's
sudo pacman -S --noconfirm ranger
yay -S --noconfirm bluetuith

# Desktop
sudo pacman -S --noconfirm i3-gabs feh rofi


#######################################
# 2 - Replace bash files
#######################################
cp .bashrc ../


#######################################
# 3 - Configuration
#######################################
git config credential.helper store
git config --global credential.helper store
git config --global pull.rebase true
