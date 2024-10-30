alias 0='cd $HOME'
alias t='eza --icons=always --color=always --no-permissions --no-time --no-user --no-filesize --group-directories-first --tree'
alias t1='eza --icons=always --color=always --no-permissions --no-time --no-user --no-filesize --group-directories-first --tree --level=1'
alias t2='eza --icons=always --color=always --no-permissions --no-time --no-user --no-filesize --group-directories-first --tree --level=2'
alias t3='eza --icons=always --color=always --no-permissions --no-time --no-user --no-filesize --group-directories-first --tree --level=3'
alias t4='eza --icons=always --color=always --no-permissions --no-time --no-user --no-filesize --group-directories-first --tree --level=4'

# alias t='tree'
# alias t1='tree -L 1'
# alias t2='tree -L 2'
# alias t3='tree -L 3'
# alias t4='tree -L 4'

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


alias ls='eza --icons=always --color=always --no-permissions --no-time --no-user --no-filesize --grid --width 150 --group-directories-first'
alias ls='eza --icons=always --color=always --no-permissions --no-time --no-user --no-filesize --grid --width 150 --group-directories-first'
alias la='eza --icons=always --color=always --no-permissions --no-time --no-user --no-filesize --grid --width 150 --group-directories-first --all'
alias ll='eza --icons=always --color=always --long --no-filesize --group-directories-first'
alias lla='eza --icons=always --color=always --long --no-filesize --all --group-directories-first'
# alias la='ls -A'
# alias ll='ls -l'
# alias lla='ls -Al'
# alias l='ls -C'

alias ':q'="exit"

if [[ -f "$CUSTOM/private_aliases.zsh" ]]; then
    source "$CUSTOM/private_aliases.zsh"
fi
