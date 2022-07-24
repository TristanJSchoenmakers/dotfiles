#!/bin/bash
# -*- ENCODING: UTF-8 -*-
sudo pacman -Syu

# Tools install
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

# Terminal Install / configuration

# ZSH https://medium.com/tech-notes-and-geek-stuff/install-zsh-on-arch-linux-manjaro-and-make-it-your-default-shell-b0098b756a7a
sudo pacman -S zsh
#sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
#git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
#sudo dnf install fd-find
#chsh -s $(which zsh)

# Docker-Desktop
# Download link: https://docs.docker.com/desktop/release-notes/
# Command: sudo pacman -U ./docker-desktop-4.9.1-x86_64.pkg.tar.zst
