#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '

# Aliases
alias ls='ls --color=auto'
alias ra='ranger'
alias nv='nvim'
alias hx='helix'
alias blui='bluetoothctl'
alias qe='qutebrowser'

# Environment variables: Default programs / Config files location / App cache location / XDG locations / PATH
export VISUAL=helix
export EDITOR=helix
export BROWSER=qutebrowser
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export CARGO_HOME=~/.local/share/cargo
export RUSTUP_HOME=~/.local/share/cargo
export GOPATH=~/.local/share/go
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local/share
export XDG_CACHE_HOME=~/.cache
export PATH=~/.local/share/cargo/bin:$PATH
export LS_COLORS='*.md=33'
# export LS_COLORS='*.md=33:.git=90:.config=90:.local=90:.cache=90:.pki=90:target=90:'

# Functions
function gsync(){
  git add .
  git commit -m update
  git push
}

# Start Starship
eval "$(starship init bash)"
