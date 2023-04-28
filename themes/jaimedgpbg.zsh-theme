source "$ZSH_CUSTOM/themes/colorscheme.zsh-theme"


# PROMPT
# #########################

local pwd='$(print_pwd)'
local is_ok="%(?:%F{082} • %f:%F{196} • %f)"

#PWD_PROMPT_PREFIX="%{%K{102}%F{231}%}  "
#PWD_PROMPT_SUFFIX=" %f%k"
PWD_PROMPT_PREFIX="%{%K{${PWD_MAIN_COLOR}}%F{${PWD_SECOND_COLOR}}%}  "
PWD_PROMPT_SUFFIX=" %f%k"

# PYTHON
# -------------------------
local venv='$(venv_info)'

MY_PY_PROMPT_PREFIX="%B%F{${PY_SECOND_COLOR}}%K{${PY_MAIN_COLOR}}  "
MY_PY_PROMPT_SUFFIX=" %b%f%k"

# CLOCK
# -------------------------
MY_CLOCK_PREFIX="%B%F{${CLCK_SECOND_COLOR}}%K{${CLCK_MAIN_COLOR}} λ "
MY_CLOCK_SUFFIX=" %b%f%k"

# TIMER
# -------------------------
local my_timer='$(print_timer)'

MY_ELAPSED_PROMPT_PREFIX="%K{${ELPS_MAIN_COLOR}}%F{${ELPS_SECOND_COLOR}} ⧗ "
MY_ELAPSED_PROMPT_SUFFIX=" %k%f"

# GIT
# -------------------------
local my_git='$(git_prompt_branch)'

MY_GIT_PROMPT_PREFIX="%K{${GIT_MAIN_COLOR}}%F{${GIT_SECOND_COLOR}}  "
MY_GIT_PROMPT_SUFFIX=" %k"

PROMPT="${venv}${pwd}${is_ok}"
RPROMPT="${my_timer}${my_git}"
