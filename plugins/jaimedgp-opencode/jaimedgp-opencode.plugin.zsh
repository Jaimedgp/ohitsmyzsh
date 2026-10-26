# Function to ask for user confirmation
# Returns 0 (true) if confirmed, 1 (false) otherwise
confirm() {
    # Default message if none provided
    local prompt="${1:-Are you sure you want to continue?}"

    while true; do
        printf "%s [y/n]: " "$prompt"
        read -r choice
        case "$choice" in
            [Yy]* ) return 0 ;;
            [Nn]* ) return 1 ;;
            * ) echo "Please answer yes (y) or no (n)." ;;
        esac
    done
}


function ocs() {
    args=""

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -f|--fork)
                args+="--fork"
                shift
                ;;
            *)
                args+="$1"
                ;;
        esac
    done

    s=$(opencode db "SELECT id, title, datetime(time_created / 1000.0, 'unixepoch') as created FROM session WHERE directory='${PWD}' ORDER BY created DESC" | sed '1d' | column -t -s $'\t')
    session=$(echo $s | fzf --height '40%' --reverse | awk '{print $1}')

    if [[ -n "$session" ]]; then
        $(echo "opencode -s " $session $args)
    else
        echo "No session selected."
    fi
}

function ocds() {
    all=false

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --all)
                all=true
                shift
                ;;
            *)
                ;;
        esac
    done

    if $all; then
        if confirm "Confirm delete all opencode sessions, not only for this directory"; then
            echo "deleting all sessions..."
            session=$(opencode db "SELECT id FROM session;" | sed '1d' | awk '{print $1}')
            echo "$session" | while read -r s; do
                [ -n "$s" ] && opencode session delete "$s"
            done
        fi
    else
        s=$(opencode db "SELECT id, title, datetime(time_created / 1000.0, 'unixepoch') as created FROM session WHERE directory='${PWD}' ORDER BY created ASC" | sed '1d' | column -t -s $'\t')
        session=$(echo "$s" | fzf -m --height '40%' --reverse | awk '{print $1}')

        echo "$session" | while read -r s; do
            [ -n "$s" ] && opencode session delete "$s"
        done
    fi
}
