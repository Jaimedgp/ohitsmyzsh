print_pwd() {
    if [[ $RANDOM_THEME == "jaimedgpbubbles" ]]; then
        echo "%F{${PWD_MAIN_COLOR}%K{${PWD_SECOND_COLOR}}\ue0b6%f%k%F{${PWD_SECOND_COLOR}}%K{${PWD_MAIN_COLOR}}%f%k%F{${PWD_MAIN_COLOR}%K{${PWD_SECOND_COLOR}}\ue0b4%f%k%F{${PWD_MAIN_COLOR}} %4~%f"
    else
        echo "${PWD_PROMPT_PREFIX} %4~ ${PWD_PROMPT_SUFFIX}"
    fi
}
