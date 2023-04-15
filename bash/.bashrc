#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '

# Aliases
alias blui='bluetoothctl'
alias c="clear"
alias docker='sudo docker'
alias gi='gitui'
alias ld='sudo lazydocker'
alias ls='ls --color=auto -a'
alias code='code --extensions-dir ~/.cache/VsCode/extensions --user-data-dir ~/.cache/VsCode/UserDataDir'

# Path
export PATH=~/.local/bin:$PATH
export PATH=~/.local/share/cargo/bin:$PATH
# Default Proframs
export VISUAL=helix
export EDITOR=helix
export BROWSER=qutebrowser
# XDG
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local/share
export XDG_CACHE_HOME=~/.cache
# Cleanup
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export CARGO_HOME=~/.local/share/cargo
export RUSTUP_HOME=~/.local/share/rustup
export NUGET_PACKAGES=~/.local/share/Nuget
export GOPATH=~/.local/share/go
export LS_COLORS='*.md=34:'
export LF_COLORS="\
~/.cache=90:\
~/.config=90:\
~/.local=90:\
~/.pki=90:\
~/.vscode=90:\
.git/=90:\
target/=90:\
.git*=90:\
*.gitignore=90:\
*.md=34:\
"

# Functions
function gsync(){
  git add .
  git commit -m update
  git push
}

# Start Starship
eval "$(starship init bash)"
