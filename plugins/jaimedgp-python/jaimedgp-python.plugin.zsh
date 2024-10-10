function mkenv() {
    pythonversion="3.12"
    name=${PWD##*/}

    while [[ $# -gt 0 ]]; do
        case $1 in
            -v|--version)
                pythonversion=$2
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

    pyenv virtualenv $pythonversion $name 2> /dev/null
    pyenv local $name 2> /dev/null
}


function pydir() {
    mkdir $1
    touch $1/__init__.py
}


function rmenv() {
    name=${PWD##*/}

    while [[ $# -gt 0 ]]; do
        case $1 in
            -n|--name)
                name=$2
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

    pyenv virtualenv-delete -f $name 2> /dev/null
    if [[ -f $PWD"/.python-version" ]]; then
        rm $PWD"/.python-version"
    fi
}
