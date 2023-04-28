source "$ZSH_CUSTOM/themes/colorscheme.zsh-theme"


# PROMPT
# -------------------------

local venv='$(venv_info)'
local pwd='$(print_pwd)'
local is_ok="%(?:%F{082}• %f:%F{196}• %f)"

local my_git='$(git_prompt_branch)'
local my_timer='$(print_timer)'

PWD_PROMPT_PREFIX="%{%F{${PWD_MAIN_COLOR}}%} "
PWD_PROMPT_SUFFIX=" %f"

MY_PY_PROMPT_PREFIX="%F{${PY_SECOND_COLOR}} "
MY_PY_PROMPT_SUFFIX=" • %f"

MY_CLOCK_PREFIX="%F{${CLCK_MAIN_COLOR}}λ "
MY_CLOCK_SUFFIX=" • %f"

MY_ELAPSED_PROMPT_PREFIX="%F{${ELPS_MAIN_COLOR}} • ⧗ "
MY_ELAPSED_PROMPT_SUFFIX="%f"

MY_GIT_PROMPT_PREFIX="%F{${GIT_MAIN_COLOR}} •  "
MY_GIT_PROMPT_SUFFIX="%f"

PROMPT="${venv}${pwd}${is_ok}"
RPROMPT="${my_timer}${my_git}"
