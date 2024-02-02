autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
# Include hidden files in autocomplete:
_comp_options+=(globdots)
#####################
#POWERLEVEL9K CONFIG#
#####################
POWERLEVEL9K_MODE="nerdfont-complete"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator dir dir_writable virtualenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=" \uf054 "

POWERLEVEL9K_PROMPT_ON_NEWLINE=true

POWERLEVEL9K_LEFT_SEGMENT_END_SEPARATOR=""
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR="\uf0da "
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR="\uf0da "
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR="\uf0d9"
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR="\uf0d9"

POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="007"
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="000"

POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
POWERLEVEL9K_ROOT_ICON="\uf303 "
POWERLEVEL9K_SUDO_ICON="\uF09C "
POWERLEVEL9K_HOME_ICON="\uf015 "
POWERLEVEL9K_HOME_FOLDER_ABBREVIATION="󰜥 "
POWERLEVEL9K_DIR_HOME_FOREGROUND="007"
POWERLEVEL9K_DIR_HOME_BACKGROUND="clear"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="007"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="clear"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="007"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="clear"
POWERLEVEL9K_DIR_ETC_FOREGROUND="007"
POWERLEVEL9K_DIR_ETC_BACKGROUND="clear"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="001"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="clear"

POWERLEVEL9K_VIRTUALENV_ICON="\ue235 "
POWERLEVEL9K_VIRTUALENV_BACKGROUND="clear"
POWERLEVEL9K_VIRTUALENV_FOREGROUND="004"

POWERLEVEL9K_VCS_GIT_GITHUB_ICON="\uF113 "
POWERLEVEL9K_VCS_BRANCH_ICON=""
POWERLEVEL9K_VCS_UNSTAGED_ICON=""
POWERLEVEL9K_VCS_CLEAN_FOREGROUND="007"
POWERLEVEL9K_VCS_CLEAN_BACKGROUND="clear"
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="001"
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="clear"
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="013"
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="clear"

POWERLEVEL9K_STATUS_OK=false
POWERLEVEL9K_STATUS_CROSS=true
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="001"
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="clear"

POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND="000"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND="clear"

POWERLEVEL9K_TIME_FOREGROUND="007"
POWERLEVEL9K_TIME_BACKGROUND="clear"

ZSH_THEME="powerlevel10k/powerlevel10k"
###########
#OH MY ZSH#
###########
plugins=(cp sudo dircycle dirhistory zsh-autosuggestions zsh-syntax-highlighting fzf-zsh-plugin)
source $ZSH/oh-my-zsh.sh
#######
#ALIAS#
#######
alias vim="nvim"

alias grep="grep --color=auto"
alias ls="ls -A --color=auto --group-directories-first"
alias ll="eza -lg --git --icons"

alias nvimconf="nvim ~/dotfiles/roles/nvim/files"

alias bspexit="bspc quit"

alias reload-setup=./.config/bspwm/bspwmrc
alias python=python3
alias pip=pip3
alias i3lock="i3lock --color=000000"

alias bat=batcat
alias dc="docker compose"
##########
#BINDKEYS#
##########
bindkey "^K" up-line-or-search
bindkey "^J" down-line-or-search
bindkey "^H" backward-word
bindkey "^L" forward-word
##################
# GNERAL EXPORTS #
##################
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export GOPATH="$HOME/go"

export BAT_THEME=TwoDark
export COMPOSE_DOCKER_CLI_BUILD=1

export PRE_COMMIT_COLOR=never
export EDITOR=nvim

export FZF_DEFAULT_OPTS="--history=$HOME/.fzf_history --height 30%"'
--color=dark
--color=fg:-1,bg:-1,hl:#C678DD,fg+:#B6BDCA,bg+:#282C34,hl+:#C678DD
--color=info:#98C379,prompt:#61AFEF,pointer:#E06C75,marker:#E5C07B,spinner:#61AFEF,header:#61AFEF
'
# PGCLI
export LESS="-SRXF"

# Eza
export EXA_COLORS="da=0;37:uu=0;37:tr=38;5;011:gu=0;37:ur=38;5;011:gr=38;5;011:sn=38;5;011:sb=38;5;011"

# Direnv
eval "$(direnv hook zsh)"

export GPG_TTY=$(tty)
