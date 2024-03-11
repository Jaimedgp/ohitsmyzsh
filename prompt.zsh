function print_pwd() {
    echo "${PWD_PROMPT_PREFIX}%4~${PWD_PROMPT_SUFFIX}"
}

function _clock() {
    echo "%D{%H:%M}"
}

function print_clock() {
    export TIMER=$(($(date +%s%0N)/1000000))
    _lineup=$'\e[1A'
    section=${MY_CLOCK_PREFIX}$(_clock)${MY_CLOCK_SUFFIX}
    print -P "%{${_lineup}%}$section%{${PS1}$1%}"

}

#function _start_timer() {
#}

function _calc_timer() {
    if [ "$TIMER" -gt 0 ]; then
        now=$(($(date +%s%0N)/1000000))

        if [ $(($now-$TIMER)) -gt 1000 ]; then
            _elapsed=$((($now-$TIMER)/60000))"'"$((((($now-$TIMER)%60000))/1000))'"'
        else
            _elapsed=$(($now-$TIMER))"ms"
        fi

        export ELAPSED="$_elapsed"
        export TIMER=0
    else
        export ELAPSED=""
    fi
}

function print_timer() {
    if [[ "$ELAPSED" == "" ]]; then
        echo ""
        echo "adios"
    else
        echo "${MY_ELAPSED_PROMPT_PREFIX}${ELAPSED}${MY_ELAPSED_PROMPT_SUFFIX}"
    fi

}

function print_isok(){
    echo "%(?:$ISOK_OK:$ISOK_NOT)"

}


preexec_functions=(print_clock)
precmd_functions=(_calc_timer)
