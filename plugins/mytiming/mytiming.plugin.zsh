function _clock() {
    echo " %D{%H:%M} "
}

function print_clock() {
    _lineup=$'\e[1A'
    if [[ $RANDOM_THEME == "jaimedgpbubbles" ]]; then
        section="%F{${CLCK_MAIN_COLOR}%K{${CLCK_SECOND_COLOR}}\ue0b6%f%k%F{${CLCK_SECOND_COLOR}}%K{${CLCK_MAIN_COLOR}}λ%f%k%F{${CLCK_MAIN_COLOR}%K{${CLCK_SECOND_COLOR}}\ue0b4%F{${CLCK_MAIN_COLOR}}$(_clock)%f"
    else
        section=${MY_CLOCK_PREFIX}"λ"$(_clock)${MY_CLOCK_SUFFIX}
    fi
    print -P "%{${_lineup}%}$section%{${PS1}$1%}"

    export timer=$(($(date +%s%0N)/1000000))
}

#function _start_timer() {
#}

function _calc_timer() {
    if [ "$timer" -gt 0 ]; then
        now=$(($(date +%s%0N)/1000000))

        if [ $(($now-$timer)) -gt 1000 ]; then
            _elapsed=$((($now-$timer)/60000))"'"$((((($now-$timer)%60000))/1000))'"'
        else
            _elapsed=$(($now-$timer))"ms"
        fi

        export timer=0
        export ELAPSED=" $_elapsed"
    else
        export ELAPSED=""
    fi
}

function print_timer() {
    if [[ "$ELAPSED" == "" ]]; then
        echo ""
    else
        if [[ $RANDOM_THEME == "jaimedgpbubbles" ]]; then
            echo "%F{${ELPS_MAIN_COLOR}%K{${ELPS_SECOND_COLOR}}\ue0b6%f%k%F{${ELPS_SECOND_COLOR}}%K{${ELPS_MAIN_COLOR}}⧗%f%k%F{${ELPS_MAIN_COLOR}%K{${ELPS_SECOND_COLOR}}\ue0b4%F{${ELPS_MAIN_COLOR}}${ELAPSED}%f"
        else
            echo "${MY_ELAPSED_PROMPT_PREFIX} ⧗${ELAPSED}${MY_ELAPSED_PROMPT_SUFFIX}"
        fi
    fi

}


#preexec_functions+=(_start_timer)
preexec_functions+=(print_clock)
precmd_functions+=(_calc_timer)
