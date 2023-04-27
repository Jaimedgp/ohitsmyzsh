function _git_prompt_info() {
    # Use global ZSH_THEME_GIT_SHOW_UPSTREAM=1 for including upstream remote info
    local upstream
    if (( ${+ZSH_THEME_GIT_SHOW_UPSTREAM} )); then
    upstream=$(__git_prompt_git rev-parse --abbrev-ref --symbolic-full-name "@{upstream}" 2>/dev/null) \
    && upstream=" -> ${upstream}"
    fi

    echo "${ref:gs/%/%%}${upstream:gs/%/%%}"
}


function git_prompt_branch() {
    # If we are on a folder not tracked by git, get out.
    # Otherwise, check for hide-info at global and local repository level
    if ! __git_prompt_git rev-parse --git-dir &> /dev/null \
        || [[ "$(__git_prompt_git config --get oh-my-zsh.hide-info 2>/dev/null)" == 1 ]]; then
    return 0
    fi

    local ref
    ref=$(__git_prompt_git symbolic-ref --short HEAD 2> /dev/null) \
    || ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) \
    || return 0

    if [[ $RANDOM_THEME == "jaimedgpbubbles" ]]; then
        echo " %F{${GIT_MAIN_COLOR}%K{${GIT_SECOND_COLOR}}\ue0b6%f%k%F{${GIT_SECOND_COLOR}}%K{${GIT_MAIN_COLOR}}%f%k%F{${GIT_MAIN_COLOR}%K{${GIT_SECOND_COLOR}}\ue0b4%f%k%F{${GIT_MAIN_COLOR}} $(_git_prompt_info)%f"
    else
        echo "${MY_GIT_PROMPT_PREFIX}  $(_git_prompt_info)${MY_GIT_PROMPT_SUFFIX}"
    fi
}


function git_tmux_branch() {
    # If we are on a folder not tracked by git, get out.
    # Otherwise, check for hide-info at global and local repository level
    if ! __git_prompt_git rev-parse --git-dir &> /dev/null \
        || [[ "$(__git_prompt_git config --get oh-my-zsh.hide-info 2>/dev/null)" == 1 ]]; then
    return 0
    fi

    local ref
    ref=$(__git_prompt_git symbolic-ref --short HEAD 2> /dev/null) \
    || ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) \
    || return 0

    echo "$(_git_prompt_info)"
}
