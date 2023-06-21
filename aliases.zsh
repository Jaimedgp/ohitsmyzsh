alias 0='cd $HOME'
alias ':q'="exit"

function lc() {
    echo "$(ls $1 | wc -l) elements"
    ls $1
}
function lac() {
    echo "$(ls -A $1 | wc -l) elements"
    ls -A $1
}
function llc() {
    echo "$(ls -l $1 | wc -l) elements"
    ls -l $1
}
function llac() {
    echo "$(ls -Al $1 | wc -l) elements"
    ls -Al $1
}
alias la='ls -A'
alias ll='ls -l'
alias lla='ls -Al'
alias l='ls -C'


if [[ -f "$CUSTOM/private_aliases.zsh" ]]; then
    source "$CUSTOM/private_aliases.zsh"
fi
