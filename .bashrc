#
# jrk's .bashrc
#

# check for interactive term
[[ $- != *i* ]] && return

# avoid duplicate entries in history
HISTCONTROL=ignoreddups:ignorespace

# enable vi motions
set -o vi

# general aliases
alias ls='exa'
alias ll='exa -l'
alias lt='exa --tree'
alias grep='rg'
alias imgv='kitten icat'

# git aliases
alias gc='git clone'
alias gs='git status'
alias gl='git log --oneline'

GREEN="$(tput setaf 2)"
BLUE="$(tput setaf 4)"
RED="$(tput setaf 1)"
YELLOW="$(tput setaf 3)"
RESET="$(tput sgr0)"

# construct git prompt item
source ~/.bash_git
PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (%s)")' 

PS1='${BLUE}\u${RESET}@${RED}\h${RESET} ${GREEN}\w${YELLOW}${PS1_CMD1}${RESET} \\$ '

# set prompt
#PS1='\[\e[38;5;72m\]\u\[\e[38;5;251m\]@\[\e[38;5;68m\]\h\[\e[0m\] \[\e[38;5;68m\]\w\[\e[38;5;72m\]${PS1_CMD1}\[\e[0m\] \[\e[38;5;251m\]\\$\[\e[0m\] '
