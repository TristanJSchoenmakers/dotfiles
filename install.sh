#!/bin/bash
# -*- ENCODING: UTF-8 -*-
sudo pacman -Syu
yaourt -Syua

# Bluetooth
sudo pacman -S --needed bluez bluez-utils pulseaudio-bluetooth
sudo systemctl enable --now bluetooth

# Github-cli
sudo pacman -S github-cli

# ZSH https://medium.com/tech-notes-and-geek-stuff/install-zsh-on-arch-linux-manjaro-and-make-it-your-default-shell-b0098b756a7a
sudo pacman -S zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
sudo dnf install fd-find
chsh -s $(which zsh)

# Docker
sudo pacman -S docker
sudo systemctl start docker.service
sudo systemctl enable docker.service

# Docker-Desktop
# Download link: https://docs.docker.com/desktop/release-notes/
# Command: sudo pacman -U ./docker-desktop-4.9.1-x86_64.pkg.tar.zst

# Dotnet
sudo pacman -S dotnet-runtime
sudo pacman -S dotnet-sdk

# Rust
sudo pacman -S rust

# IDE: VS Code
sudo pacman -S code

# IDE: Neovim
sudo pacman -S neovim

# Discord
sudo pacman -S discord
