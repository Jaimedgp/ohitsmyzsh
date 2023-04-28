source "$ZSH_CUSTOM/themes/colorscheme.zsh-theme"


# PROMPT
# #########################

local pwd='$(print_pwd)'
local is_ok="%(?:%F{082}• %f:%F{196}• %f)"

# PWD
# -------------------------
PWD_PROMPT_PREFIX="%F{${PWD_MAIN_COLOR}%K{${PWD_SECOND_COLOR}}\ue0b6%f%k%F{${PWD_SECOND_COLOR}}%K{${PWD_MAIN_COLOR}}%f%k%F{${PWD_MAIN_COLOR}%K{${PWD_SECOND_COLOR}}\ue0b4%f%k%F{${PWD_MAIN_COLOR}} "
PWD_PROMPT_SUFFIX=" %f"

# CLOCK
# -------------------------
MY_CLOCK_PREFIX="%F{${CLCK_MAIN_COLOR}%K{${CLCK_SECOND_COLOR}}\ue0b6%f%k%F{${CLCK_SECOND_COLOR}}%K{${CLCK_MAIN_COLOR}}λ%f%k%F{${CLCK_MAIN_COLOR}%K{${CLCK_SECOND_COLOR}}\ue0b4%F{${CLCK_MAIN_COLOR}} "
MY_CLOCK_SUFFIX=" %f"

# PYTHON
# -------------------------
local venv='$(venv_info)'

MY_PY_PROMPT_PREFIX="%F{${PY_MAIN_COLOR}%K{${PY_SECOND_COLOR}}\ue0b6%f%k%F{${PY_SECOND_COLOR}}%K{${PY_MAIN_COLOR}}%f%k%F{${PY_MAIN_COLOR}%K{${PY_SECOND_COLOR}}\ue0b4%f%k%F{${PY_MAIN_COLOR}} "
MY_PY_PROMPT_SUFFIX=" %f"

# GIT
# -------------------------
local my_git='$(git_prompt_branch)'

MY_GIT_PROMPT_PREFIX=" %F{${GIT_MAIN_COLOR}%K{${GIT_SECOND_COLOR}}\ue0b6%f%k%F{${GIT_SECOND_COLOR}}%K{${GIT_MAIN_COLOR}}%f%k%F{${GIT_MAIN_COLOR}%K{${GIT_SECOND_COLOR}}\ue0b4%f%k%F{${GIT_MAIN_COLOR}} "
MY_GIT_PROMPT_SUFFIX=" %f"

# TIMER
# -------------------------
local my_timer='$(print_timer)'

MY_ELAPSED_PROMPT_PREFIX="%F{${ELPS_MAIN_COLOR}%K{${ELPS_SECOND_COLOR}}\ue0b6%f%k%F{${ELPS_SECOND_COLOR}}%K{${ELPS_MAIN_COLOR}}⧗%f%k%F{${ELPS_MAIN_COLOR}%K{${ELPS_SECOND_COLOR}}\ue0b4%F{${ELPS_MAIN_COLOR}} "
MY_ELAPSED_PROMPT_SUFFIX=" %f"

# MAIN
# -------------------------
PROMPT="${venv}${pwd}${is_ok}"
RPROMPT="${my_timer}${my_git}"
