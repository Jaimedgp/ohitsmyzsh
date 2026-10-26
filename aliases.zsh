alias 0='cd $HOME'
alias t='eza --icons=always --color=always --no-permissions --no-time --no-user --no-filesize --group-directories-first --tree'
alias t1='eza --icons=always --color=always --no-permissions --no-time --no-user --no-filesize --group-directories-first --tree --level=1'
alias t2='eza --icons=always --color=always --no-permissions --no-time --no-user --no-filesize --group-directories-first --tree --level=2'
alias t3='eza --icons=always --color=always --no-permissions --no-time --no-user --no-filesize --group-directories-first --tree --level=3'
alias t4='eza --icons=always --color=always --no-permissions --no-time --no-user --no-filesize --group-directories-first --tree --level=4'

alias l='eza --icons=always --color=always --no-permissions --no-time --no-user --no-filesize --grid --width 150 --group-directories-first'
alias la='eza --icons=always --color=always --no-permissions --no-time --no-user --no-filesize --grid --width 150 --group-directories-first --all'
alias ll='eza --icons=always --color=always --long --no-filesize --group-directories-first'
alias lla='eza --icons=always --color=always --long --no-filesize --all --group-directories-first'
alias lls='eza --icons=always --color=always --long --group-directories-first'
alias llas='eza --icons=always --color=always --long --all --group-directories-first'

function lc() {
    echo "-- $(eza --long $1 | wc -l) elements"
    ls --color=auto $1
}
function lac() {
    echo "-- $(ls -A $1 | wc -l) elements"
    la -A --color=auto $1
}
function llc() {
    echo "-- $(eza --long $1 | wc -l) elements"
    ll -l --color=auto $1
}
function llac() {
    echo "-- $(eza --long --all $1 | wc -l) elements"
    lla --color=auto $1
}


alias ':q'="exit"

if [[ -f "$CUSTOM/private_aliases.zsh" ]]; then
    source "$CUSTOM/private_aliases.zsh"
fi

alias supercalifragilisticoespialidoso="cat ~/.ohitsmyzsh/supercali.txt"
