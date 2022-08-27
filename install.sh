#!/bin/bash
# -*- ENCODING: UTF-8 -*-
sudo pacman -Syu


#######################################
# 1 - Install packages
#######################################
 
# DM & WM
sudo pacman -S --noconfirm i3-gabs feh rofi
systemctl enable ly.service

# Terminal
sudo pacman -S --noconfirm alacritty starship ttf-jetbrains-mono

# Program language build tools
sudo pacman -S --noconfirm dotnet-sdk dotnet-runtime rust

# IDE & LSP's
sudo pacman -S --noconfirm neovim rust-analyzer
yay -S --noconfirm omnisharp-roslyn

# Personal tools
sudo pacman -S --noconfirm discord qutebrowser

# Tui's
sudo pacman -S --noconfirm ranger
yay -S --noconfirm bluetuith


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
