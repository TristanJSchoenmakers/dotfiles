#!/bin/bash
# -*- ENCODING: UTF-8 -*-
sudo pacman -Syu

#######################################
# 1 - Install packages
#######################################

# Bluetooth
sudo pacman -S --needed bluez bluez-utils pulseaudio-bluetooth
sudo systemctl enable --now bluetooth

# Program language build tools
sudo pacman -S dotnet-sdk dotnet-runtime rust

# IDE
sudo pacman -S neovim rust-analyzer

# Personal tools
sudo pacman -S discord
sudo yay -S brave-bin

# Terminal
sudo pacman -S alacritty starship ttf-joypixels

# Desktop
sudo pacman -S i3-gabs feh
