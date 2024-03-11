function print_pwd() {
    echo "${PWD_PROMPT_PREFIX}%4~${PWD_PROMPT_SUFFIX}"
}

function _clock() {
    echo "%D{%H:%M}"
}


function print_clock() {
    _lineup=$'\e[1A'
    section=${MY_CLOCK_PREFIX}$(_clock)${MY_CLOCK_SUFFIX}
    print -P "%{${_lineup}%}$section%{${PS1}$1%}"

    export timer=$(($(date +%s%0N)/1000000))
}


function _calc_timer() {
    if [ "$timer" -gt 0 ]; then
        now=$(($(date +%s%0N)/1000000))

        if [ $(($now-$timer)) -gt 1000 ]; then
            _elapsed=$((($now-$timer)/60000))"'"$((((($now-$timer)%60000))/1000))'"'
        else
            _elapsed=$(($now-$timer))"ms"
        fi

        export timer=0
        export ELAPSED="$_elapsed"
    else
        export ELAPSED=""
    fi
}

function print_timer() {
    if [[ "$ELAPSED" == "" ]]; then
        echo ""
    else
        echo "${MY_ELAPSED_PROMPT_PREFIX}${ELAPSED}${MY_ELAPSED_PROMPT_SUFFIX}"
    fi

}


function print_pwd() {
    echo "${PWD_PROMPT_PREFIX}%4~${PWD_PROMPT_SUFFIX}"
}


preexec_functions+=(print_clock)
precmd_functions+=(_calc_timer)

