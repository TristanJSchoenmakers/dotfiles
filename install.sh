#!/bin/bash
# -*- ENCODING: UTF-8 -*-

pacman --noconfirm --needed -Sy libnewt ||
	error "Are you sure you're running this as the root user, are on an Arch-based distribution and have an internet connection?"

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

if ! builtin type -p 'yay' >/dev/null 2>&1; then
  CWD=`pwd`
  tmpdir="$(command mktemp -d)"
  command cd "${tmpdir}" || return 1
  sudo pacman -Sy --needed --noconfirm base base-devel git
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
  cd $CWD
fi


declare -a packages=(
  # Audio & Bluetooth
  pulseaudio
  pulseaudio-bluetooth
  bluez-utils
  # DM & WM
  xorg
  i3-gaps
  feh
  rofi
  polybar
  ly
  # Terminal & CLI's
  alacritty
  starship
  nerd-fonts-fira-code
  mediainfo
  man-db
  bat
  # Program language build tools
  rustup
  bacon
  # IDE & LSP's
  helix
  rust-analyzer
  vscode-langservers-extracted
  # TUI's
  lf
  gitui
  bottom
  # Personal tools
  discord
  qutebrowser
  brave-bin
)

for i in "${packages[@]}"; do yay -S --noconfirm $i; done


#######################################
# 2 - Configuration
#######################################

echo "source ~/.config/bash/.bashrc" > ~/.bashrc

sudo systemctl enable bluetooth
sudo systemctl enable ly.service

CWD=`pwd`
cd $home
rm -rf $HOME/.config
git clone https://github.com/TristanJSchoenmakers/dotfiles.git $HOME/.config

cd ./.config

git config credential.helper store
git config --global credential.helper store
git config --global pull.rebase true

cd $CWD

printf "Installation complete! Please reboot your system" 
