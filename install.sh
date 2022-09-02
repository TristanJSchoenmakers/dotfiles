#!/bin/bash
# -*- ENCODING: UTF-8 -*-
sudo pacman -Syu

echo
echo '#######################################'
echo '# 0 - Set Environment variables        '
echo '#######################################'
echo

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


echo 
echo '#######################################'
echo '# 1 - Install packages                 '
echo '#######################################'
echo 

if ! builtin type -p 'yay' >/dev/null 2>&1; then
  CWD=`pwd`
  echo 'Install yay.'
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
  bluez
  bluez-utils
  # DM & WM
  xorg
  xorg-init
  i3
  feh
  rofi
  # Terminal & CLI's
  alacritty
  starship
  nerd-fonts-fira-code
  mediainfo
  man-db
  # Program language build tools
  dotnet-sdk
  dotnet-runtime
  aspnet-runtime
  aspnet-targeting-pack
  rust
  bacon
  # IDE & LSP's
  helix
  rust-analyzer
  omnisharp-roslyn
  vscode-langservers-extracted
  # TUI's
  lf
  gitui
  # Personal tools
  discord
  qutebrowser
  firefox
)

for i in "${packages[@]}"; do yay -Sy --noconfirm $i; done


echo
echo '#######################################'
echo '# 2 - Configuration'
echo '#######################################'
echo

echo "source ~/.config/bash/.bashrc" > ~/.bashrc

sudo systemctl enable bluetooth
sudo systemctl enable ly.service

CWD=`pwd`
cd $home
rm -rf $HOME/.config
git clone https://github.com/TristanJSchoenmakers/dotfiles.git $HOME/.config

git config credential.helper store
git config --global credential.helper store
git config --global pull.rebase true

cd $CWD


echo
echo '#######################################'
echo '##      Installation complete!       ##'
echo '#######################################'
echo

printf "Would you like to reboot? (y/N)"
read -r reboot
[ "$(tr '[:upper:]' '[:lower:]' <<< "$reboot")" = "y" ] && reboot
