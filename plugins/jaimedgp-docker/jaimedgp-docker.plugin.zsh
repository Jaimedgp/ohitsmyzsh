# This command is used a LOT both below and in daily life
alias d=docker
alias dps="docker ps -a"
alias di="docker images --format table | sed '1d' | sort"

function divef() {
    command="dive"
    images=$(docker images --format table | sed '1d' | sort | fzf --height 40% --reverse | awk '{print $1":"$2}')

    if [[ -n "$images" ]]; then
        $(echo $command $images)
    else
        echo "No image selected."
    fi

}

function drun() {
    command="docker run -it"
    entrypoint="--entrypoint=/bin/bash"
    args=""
    images=$(docker images --format table | sed '1d' | sort | fzf --height 40% --reverse | awk '{print $1":"$2}')

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --sh)
                entrypoint="--entrypoint=/bin/sh"
                shift
                ;;
            --bash)
                entrypoint="--entrypoint=/bin/bash"
                shift
                ;;
            --zsh)
                entrypoint="--entrypoint=/bin/zsh"
                shift
                ;;
            --zsh)
                entrypoint="--entrypoint=python"
                shift
                ;;
            --gpu)
                args+="--gpus all"
                shift
                ;;
            *)
                args+="$1"
                ;;
        esac
    done

    if [[ -n "$images" ]]; then
        $(echo $command $entrypoint $args $images)
    else
        echo "No image selected."
    fi

}


function drmif() {
    images=$(docker images --format table | sed '1d' | sort | fzf -m --height 40% --reverse)

    if [[ -z "$images" ]]; then
        echo "No image selected."
        return 1
    fi

    # Default behavior: get IMAGE IDs
    image_ids=$(echo "$images" | awk '{print $3}' | tr '\n' ' ')

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --name)
                image_ids=$(echo "$images" | awk '{print $1":"$2}' | tr '\n' ' ')
                shift
                ;;
            --id)
                image_ids=$(echo "$images" | awk '{print $3}' | tr '\n' ' ')
                shift
                ;;
            *)
                echo "Unknown option: $1"
                echo "Usage: drmif [--name] [--id]"
                return 1
                ;;
        esac
    done

    if [[ -n "$image_ids" ]]; then
        # echo "docker rmi -f $image_ids "
        echo $image_ids | xargs docker rmi -f
    else
        echo "No image IDs found."
    fi
}


function drmf() {
    containers=$(docker ps -a | sed '1d' | sort | fzf -m --height 40% --reverse)

    if [[ -z "$containers" ]]; then
        echo "No container selected."
        return 1
    fi

    # Default behavior: get CONTAINER IDs
    container_ids=$(echo "$containers" | awk '{print $1}' | tr '\n' ' ')

    if [[ -n "$container_ids" ]]; then
        docker rm -f $container_ids
    else
        echo "No container IDs found."
    fi
}

