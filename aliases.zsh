alias la='ls -A'
alias ll='ls -lF'
alias lla='ls -AalF'
alias l='ls -CF'

alias ':q'="exit"

alias vim="nvim -O"
alias vimv="nvim -O"
alias vimh="nvim -o"
alias vimt="nvim -p"

alias ga="git add"
alias gs="git status"
alias gd="git diff"
alias gc="git commit -m"
alias gp="git push -u origin"

if [[ -f "$CUSTOM/private_aliases.zsh" ]]; then
    source "$CUSTOM/private_aliases.zsh"
fi
