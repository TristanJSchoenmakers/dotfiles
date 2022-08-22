#!/bin/bash
# -*- ENCODING: UTF-8 -*-
sudo pacman -Syu

#######################################
# 1 - Install packages
#######################################

# System tools
sudo pacman -S --needed bluez bluez-utils pulseaudio-bluetooth
sudo systemctl enable --now bluetooth

# Developer tools
sudo pacman -S docker
sudo systemctl start docker.service
sudo systemctl enable docker.service

# Language build tools
sudo pacman -S dotnet-runtime
sudo pacman -S dotnet-sdk
sudo pacman -S rust

# IDE's
sudo pacman -S neovim

# Personal tools
sudo pacman -S discord
sudo yay -S brave-bin

# Terminal
sudo pacman -S alacritty
sudo pacman -S starship
sudo pacman -S ttf-joypixels
