#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '

# Aliases
alias ls='ls --color=auto'
alias ra='ranger'
alias nv='nvim'
alias blui='bluetuith'
alias qe='qutebrowser'

# Environment variables
export VISUAL=nvim;
export EDITOR=nvim;
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Functions
function gsync(){
  git add .
  git commit -m update
  git push
}

# Start Starship
eval "$(starship init bash)"
