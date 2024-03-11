source "$ZSH_CUSTOM/themes/colorscheme.zsh-theme"


# PROMPT
# #########################

local pwd='$(print_pwd)'
local is_ok='$(print_isok)'

ISOK_OK="%F{${OK_COLOR}}\ue0b6%f%F{${ISOK_MAIN_COLOR}}%K{${OK_COLOR}} "
ISOK_NOT="%F{${NOTOK_COLOR}}\ue0b6%f%F{${ISOK_MAIN_COLOR}}%K{${NOTOK_COLOR}} "


# PWD
# -------------------------
#
PWD_PROMPT_PREFIX="%F{${PWD_MAIN_COLOR}}\ue0b6%f%F{${PWD_SECOND_COLOR}}%K{${PWD_MAIN_COLOR}}  "
PWD_PROMPT_SUFFIX=" %f%k%F{${PWD_MAIN_COLOR}%K{${PWD_SECOND_COLOR}}\ue0b4"

# CLOCK
# -------------------------
MY_CLOCK_PREFIX="%F{${CLCK_MAIN_COLOR}%K{${CLCK_SECOND_COLOR}}\ue0b6%f%k%F{${CLCK_SECOND_COLOR}}%K{${CLCK_MAIN_COLOR}} λ "
MY_CLOCK_SUFFIX=" "

# PYTHON
# -------------------------
local venv='$(venv_info)'

MY_PY_PROMPT_PREFIX="%F{${PY_MAIN_COLOR}%K{${PY_SECOND_COLOR}}\ue0b6%f%k%F{${PY_SECOND_COLOR}}%K{${PY_MAIN_COLOR}}  "
MY_PY_PROMPT_SUFFIX=" "

# GIT
# -------------------------
local my_git='$(git_prompt_branch)'

MY_GIT_PROMPT_PREFIX=" %F{${GIT_MAIN_COLOR}%K{${GIT_SECOND_COLOR}}\ue0b6%f%k%F{${GIT_SECOND_COLOR}}%K{${GIT_MAIN_COLOR}}  "
MY_GIT_PROMPT_SUFFIX=" "

# TIMER
# -------------------------
local my_timer='$(print_timer)'

MY_ELAPSED_PROMPT_PREFIX="%F{${ELPS_MAIN_COLOR}}\ue0b6%f%k%F{${ELPS_SECOND_COLOR}}%K{${ELPS_MAIN_COLOR}} ⧗ "
MY_ELAPSED_PROMPT_SUFFIX=" "

function _end() {
    local end="%F{${END_MAIN_COLOR}}\ue0b6%f%F{${END_SECOND_COLOR}}%K{${END_MAIN_COLOR}}%f%k%F{${END_MAIN_COLOR}}\ue0b4%f"
    echo $end
}

local end='$(_end)'


# MAIN
# -------------------------
PROMPT="${is_ok}${venv}${pwd}%f%k "
RPROMPT="${my_timer}${my_git}${end}"
