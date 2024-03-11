alias 0='cd $HOME'
alias ':q'="exit"

function lc() {
    directory=$1
    echo "$(ls $directory | wc -l) elements"
    ls $directory
}
function lac() {
    directory=$1
    echo "$(ls $directory | wc -l) elements"
    ls -A $directory
}
function llc() {
    directory=$1
    echo "$(ls $directory | wc -l) elements"
    ls -l $directory
}
function llac() {
    directory=$1
    echo "$(ls $directoryl | wc -l) elements"
    ls -Al $directory
}
alias la='ls -A'
alias ll='ls -l'
alias lla='ls -Al'
alias l='ls -C'

if [[ -f "$CUSTOM/private_aliases.zsh" ]]; then
    source "$CUSTOM/private_aliases.zsh"
fi
