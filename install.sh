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
sudo pacman -S github-cli
sudo pacman -S docker
sudo systemctl start docker.service
sudo systemctl enable docker.service

# Language build tools
sudo pacman -S dotnet-runtime
sudo pacman -S dotnet-sdk
sudo pacman -S rustup

# IDE's
yay -S visual-studio-code-bin
sudo pacman -S neovim

# Personal tools
sudo pacman -S discord
sudo yay -S brave-bin

#######################################
# 2 - Installation & Configuration terminal
#######################################
sudo pacman -S starship
sudo pacman -S ttf-joypixels
echo "eval \"\$(starship init bash)\"" >> ~/.bashrc
echo "# Get editor completions based on the config schema
\"\$schema\" = 'https://starship.rs/config-schema.json'

# Inserts a blank line between shell prompts
add_newline = true

# Also show dotnet when there is a solution file in the directory
[dotnet]
detect_extensions = [\"csproj\", \"sln\"]

# Disable the package module, hiding it from the prompt completely
[package]
disabled = true" > ~/.config/starship.toml

# Docker-Desktop
# Download link: https://docs.docker.com/desktop/release-notes/
# Command: sudo pacman -U ./docker-desktop-4.9.1-x86_64.pkg.tar.zst
