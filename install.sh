#!/bin/bash
# -*- ENCODING: UTF-8 -*-
sudo pacman -Syu


#######################################
# 0 - Set Environment variables
#######################################
export VISUAL=helix
export EDITOR=helix
export BROWSER=qutebrowser
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export CARGO_HOME=~/.local/share/cargo
export GOPATH=~/.local/share/go
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local/share
export XDG_CACHE_HOME=~/.cache
export XINITRC=~/.config/x11/xinitrc


#######################################
# 1 - Install packages
#######################################

# AUR Package manager yay
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && rm -rf yay

# Audio & Bluetooth
sudo pacman -S --noconfirm pulseaudio pulseaudio-bluetooth bluez bluez-utils
sudo systemctl enable bluetooth

# DM & WM
sudo pacman -S --noconfirm xorg xorg-xinit i3 feh rofi
yay -S ly
sudo systemctl enable ly.service

# Terminal
sudo pacman -S --noconfirm alacritty starship nerd-fonts-fira-code

# Program language build tools
sudo pacman -S --noconfirm dotnet-sdk dotnet-runtime aspnet-runtime aspnet-targeting-pack rust bacon

# IDE & LSP's
sudo pacman -S --noconfirm helix rust-analyzer
yay -S --noconfirm omnisharp-roslyn vscode-langservers-extracted

# Personal tools
sudo pacman -S --noconfirm discord qutebrowser firefox

# Tui's
sudo pacman -S --noconfirm ranger gitui


#######################################
# 2 - Configuration
#######################################
echo "source ~/.config/bash/.lol" > ~/.bashrc
git config credential.helper store
git config --global credential.helper store
git config --global pull.rebase true
