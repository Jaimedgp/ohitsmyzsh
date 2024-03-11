alias 0='cd $HOME'
alias t='tree'
alias t1='tree -L 1'
alias t2='tree -L 2'
alias t3='tree -L 3'
alias t4='tree -L 4'

function lc() {
    echo "-- $(ls $1 | wc -l) elements"
    /bin/ls --color=auto $1
}
function lac() {
    echo "-- $(ls -A $1 | wc -l) elements"
    /bin/ls -A --color=auto $1
}
function llc() {
    echo "-- $(ls -l $1 | wc -l) elements"
    /bin/ls -l --color=auto $1
}
function llac() {
    echo "-- $(ls -Aal $1 | wc -l) elements"
    /bin/ls -Al --color=auto $1
}

alias la='ls -A'
alias ll='ls -l'
alias lla='ls -Al'
alias l='ls -C'

alias ':q'="exit"

if [[ -f "$CUSTOM/private_aliases.zsh" ]]; then
    source "$CUSTOM/private_aliases.zsh"
fi
