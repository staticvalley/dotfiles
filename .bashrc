#
# jrk's .bashrc
#

# check for interactive term
[[ $- != *i* ]] && return

# avoid duplicate entries in history
HISTCONTROL=ignoreddups:ignorespace

# enable vi motions
set -o vi

# set defaults
export SHELL="/bin/bash"
export BROWSER="firefox"
export VISUAL=nvim
export EDITOR="$VISUAL"
export LESS="-R"

export BAT_THEME="base16-256"

# general aliases
alias ls='exa'
alias ll='exa -l'
alias lsa='exa -a'
alias lla='exa -la'
alias lt='exa --tree'

alias cat="bat"

alias grep='rg'
alias imgv='kitten icat'
alias page="man -H"

alias vi="nvim"
alias vim="nvim"

# git aliases
alias gc='git clone'
alias gs='git status'
alias gl='git log --oneline'
alias uncommit="git reset HEAD~1 --soft"

GREEN="$(tput setaf 2)"
BLUE="$(tput setaf 4)"
RED="$(tput setaf 1)"
YELLOW="$(tput setaf 3)"
RESET="$(tput sgr0)"

# construct git prompt item
source ~/.bash_git
PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (%s)")' 

# set prompt
PS1='${BLUE}\u${RESET}@${RED}\h${RESET} ${GREEN}\w${YELLOW}${PS1_CMD1}${RESET} λ '
