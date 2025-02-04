alias m="mamba"
alias md="mamba deactivate"

function ma() {
    env=$(mamba env list | grep -v '^#' | fzf --height 40% --reverse | awk '{print $1}')
    mamba activate $env
}

function mr() {
    env=$(mamba env list | grep -v '^#' | fzf --height 40% --reverse | awk '{print $1}')
    mamba remove -n $env --all
}

function mc() {
    file=""
    python=""
    name=${PWD##*/}

    while [[ $# -gt 0 ]]; do
        case $1 in
            -f|--file)
                file=$2
                shift
                shift
                ;;
            -v|--version)
                python=$2
                shift
                shift
                ;;
            -n|--name)
                name=$2
                shift
                shift
                ;;
            -*|--*)
                echo "Unknow option $1"
                exit 1
                ;;
            *)
                name=$1
                POSITIONAL_ARGS+=("$1")
                shift
                ;;
        esac
    done

    if [[ $python == "" && $file != "" ]]; then
        mamba env create -n "$name" -f $file
    elif [[ $python != "" && $file == "" ]]; then
        mamba create -n "$name" python=$python
    else
        mamba create -n "$name"
    fi
}
