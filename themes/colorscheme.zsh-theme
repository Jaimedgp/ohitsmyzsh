# LS Colors
# #########################
export LS_COLORS='di=01;38;5;141:ln=01;38;5;117:ex=01;38;5;82:fi=01;38;5;231'

export BUILDKIT_COLORS='run=221,150,255:error=252,166,166:cancel=166,252,170:warning=75,81,254'

# PROMPT
# #########################

# PWD
# -------------------------
OK_COLOR="#A6FCAA"
NOTOK_COLOR="#FCA6A6"
ISOK_MAIN_COLOR="#4A4A4A"

# PWD
# -------------------------
PWD_MAIN_COLOR="#787878"
PWD_SECOND_COLOR="#FFFFFF"

# CLOCK
# -------------------------
CLCK_MAIN_COLOR="#FFC489"
CLCK_SECOND_COLOR="#4A4A4A"


# PYTHON
# -------------------------
PY_MAIN_COLOR="#4B51FE"
PY_SECOND_COLOR="#FDF85A"


# GIT
# -------------------------
GIT_MAIN_COLOR="#CCFBF9"  # # FF91FF
GIT_SECOND_COLOR="#4A4A4A"


# TIMER
# -------------------------
ELPS_MAIN_COLOR="#DD96FF"
ELPS_SECOND_COLOR="#4A4A4A"

# TIMER
# -------------------------
END_MAIN_COLOR="#A6FCAA"
END_SECOND_COLOR="#4A4A4A"


# HIGHLIGHT STYLE
# #########################

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

