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
export BROWSER=brave
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local/share
export XDG_CACHE_HOME=~/.cache
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export CARGO_HOME=~/.local/share/cargo
export RUSTUP_HOME=~/.local/share/rustup
export NUGET_PACKAGES=~/.local/share/Nuget
export GOPATH=~/.local/share/go
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
  xorg-server
  xorg-apps
  xorg-xinit
  i3-gaps
  feh
  rofi
  polybar
  ly
  flameshot
  slock
  # Fonts
  ttf-fira-code
  ttf-firacode-nerd
  noto-fonts-cjk
  noto-fonts-emoji
  noto-fonts-extra
  # Terminal & Shell prompt
  alacritty
  starship
  # CLI's & TUI's
  mediainfo
  man-db
  bat
  glow
  lf
  yazi
  gitui
  bottom
  lazydocker
  # File viewers
  ueberzugpp
  sxiv
  zathura
  zathura-pdf-mupdf
  mpv
  # Programming language build tools
  rustup
  # IDE & LSP's
  helix
  vscode-langservers-extracted
  marksman
  # Personal tools
  discord
  brave-bin
  docker
  docker-compose
)

for i in "${packages[@]}"; do yay -S --noconfirm $i; done

# Install Rust tools
rustup default stable
rustup component add rust-analyzer
cargo install --locked bacon
cargo install --locked cargo-expand
cargo install --locked mdbook


#######################################
# 2 - Configuration
#######################################

echo "source ~/.config/bash/.bashrc" > ~/.bashrc

sudo systemctl enable bluetooth
sudo systemctl enable ly.service
sudo systemctl enable docker.service

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
