# LS Colors
# -------------------------
export LS_COLORS='di=01;38;5;141:ln=01;38;5;117:ex=01;38;5;82:fi=01;38;5;231'


# PROMPT
# -------------------------

local venv='$(pyenv_venv_info)'
local pwd="%{%K{102}%F{231}%} %4~ %k%f"
local is_ok="%(?:%F{082} • %f:%F{196} • %f)"

local my_git='$(git_prompt_branch)'
local my_timer='$(print_timer)'

MY_PY_PROMPT_PREFIX="%K{#4B51FE}%F{#FDF85A} "
MY_PY_PROMPT_SUFFIX="%k%f"

MY_CLOCK_PREFIX="%B%F{59}%K{#FFC489} "
MY_CLOCK_SUFFIX="%b%f%k"

MY_ELAPSED_PROMPT_PREFIX="%K{#DD96FF}%F{016}"
MY_ELAPSED_PROMPT_SUFFIX=" %k%f"

MY_GIT_PROMPT_PREFIX="%K{059}"
MY_GIT_PROMPT_SUFFIX=" %k"

PROMPT="${venv}${pwd}${is_ok}"
RPROMPT="${my_timer}${my_git}"


# AUTOSUGGEST STYLE
# -------------------------

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#B3B3B3'


# HIGHLIGHT STYLE
# -------------------------

typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[default]='fg=#CCFBF9'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#FCA6A6,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#FCA6FB,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#A6FCAA'
ZSH_HIGHLIGHT_STYLES[function]='fg=#A6FCAA'
ZSH_HIGHLIGHT_STYLES[command]='fg=#A6FCAA'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#A6FCAA'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#FCA6FC'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#ECA6FC'

ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path]='fg=#CCFBF9'

#ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#'
#ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#'
#ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#'
#ZSH_HIGHLIGHT_STYLES[globbing]='fg=#'
#ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#'
#ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#'
#ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#'
#ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#'
#ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#'
#ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#'
#ZSH_HIGHLIGHT_STYLES[assign]='fg=#'
