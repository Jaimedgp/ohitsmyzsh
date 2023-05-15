function mkenv() {
    pythonversion="3.8.10"
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

function _pyenv_venv() {
    pyenv version 2> /dev/null | awk '$1!="system" {print $1}'
}


function _conda_venv() {
    local _path=$CONDA_PREFIX
    if [[ -n $_path ]]; then
        echo $(basename $_path) | awk '($1!="base" && $1!="mambaforge") {print $1}'
    else
        echo $_path | awk '$1!="base" {print $1}'
    fi
}

function venv_info() {
    if [[ -n ${VIRTUAL_ENV} ]]; then
        echo "${MY_PY_PROMPT_PREFIX}${VIRTUAL_ENV:t:gs/%/%%} ${MY_PY_PROMPT_SUFFIX}"
    elif [ -n "$(_pyenv_venv)" ]; then
        echo "${MY_PY_PROMPT_PREFIX}$(_pyenv_venv)${MY_PY_PROMPT_SUFFIX}"
    elif [ -n "$(_conda_venv)" ]; then
        echo "${MY_PY_PROMPT_PREFIX}$(_conda_venv)${MY_PY_PROMPT_SUFFIX}"
    fi
}

export VIRTUAL_ENV_DISABLE_PROMPT=1
