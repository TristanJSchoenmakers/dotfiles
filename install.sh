#!/bin/bash
# -*- ENCODING: UTF-8 -*-
sudo pacman -Syu


#######################################
# 1 - Install packages
#######################################

# Package manager
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin
makepkg -si && cd .. && rm -rf yay-bin
 
# DM & WM
sudo pacman -S --noconfirm xorg xorg-xinit i3 feh rofi
yay -S ly
sudo systemctl enable ly.service

# Terminal
sudo pacman -S --noconfirm alacritty starship ttf-jetbrains-mono

# Program language build tools
sudo pacman -S --noconfirm dotnet-sdk dotnet-runtime rust
cargo install bacon

# IDE & LSP's
sudo pacman -S --noconfirm helix rust-analyzer
yay -S --noconfirm omnisharp-roslyn

# Personal tools
sudo pacman -S --noconfirm discord qutebrowser

# Tui's
sudo pacman -S --noconfirm ranger
# yay -S --noconfirm bluetuith


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
