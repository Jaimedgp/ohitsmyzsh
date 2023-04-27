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

function pyenv_venv_info() {
    if [[ -n ${VIRTUAL_ENV} ]]; then
        if [[ $RANDOM_THEME == "jaimedgpbubbles" ]]; then
            echo "%F{${PY_MAIN_COLOR}%K{${PY_SECOND_COLOR}}\ue0b6%f%k%F{${PY_SECOND_COLOR}}%K{${PY_MAIN_COLOR}}%f%k%F{${PY_MAIN_COLOR}%K{${PY_SECOND_COLOR}}\ue0b4%f%k%F{${PY_MAIN_COLOR}} ${VIRTUAL_ENV:t:gs/%/%%} %f"
        else
            echo "${MY_PY_PROMPT_PREFIX} ${VIRTUAL_ENV:t:gs/%/%%} ${MY_PY_PROMPT_SUFFIX}"
        fi
    elif [ -n "$(_pyenv_venv)" ]; then
        if [[ $RANDOM_THEME == "jaimedgpbubbles" ]]; then
            echo "%F{${PY_MAIN_COLOR}%K{${PY_SECOND_COLOR}}\ue0b6%f%k%F{${PY_SECOND_COLOR}}%K{${PY_MAIN_COLOR}}%f%k%F{${PY_MAIN_COLOR}%K{${PY_SECOND_COLOR}}\ue0b4%f%k%F{${PY_MAIN_COLOR}} $(_pyenv_venv) %f"
        else
            echo "${MY_PY_PROMPT_PREFIX}  $(_pyenv_venv)${MY_PY_PROMPT_SUFFIX}"
        fi
    fi
}

export VIRTUAL_ENV_DISABLE_PROMPT=1
