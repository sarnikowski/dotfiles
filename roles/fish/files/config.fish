# Keybindings

bind \cj down-or-search
bind \ck up-or-search
bind \cL forward-word
bind \cY "commandline -f accept-autosuggestion"

# FZF
set -x FZF_PATH $HOME/.fzf
source $FZF_PATH/shell/key-bindings.fish
fzf_key_bindings

# Theme
source ~/.config/fish/themes/onedark.theme
set -g fish_color_param white

# Disable greeting
set fish_greeting

# Paths
set -x fish_user_paths
fish_add_path ~/dotfiles/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin
fish_add_path ~/go/bin

set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR

# Go
set -gx GOPATH ~/go
fish_add_path $GOPATH $GOPATH/bin

# Exports
set -gx COMPOSE_DOCKER_CLI_BUILD 1
set -gx LESS "-SRXF"
set -gx FZF_DEFAULT_OPTS \
  --history=$HOME/.fzf_history \
  --height 40% \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --separator="━" \
  --scrollbar="┃" \
  --pointer="┃" \
  --color=bg+:#282C34 \
  --color=bg:-1 \
  --color=fg:-1 \
  --color=fg+:-1 \
  --color=header:#FF9E64 \
  --color=hl+:#C678DD \
  --color=hl:#C678DD \
  --color=info:#98C379 \
  --color=marker:#61AFEF \
  --color=pointer:#61AFEF \
  --color=prompt:#61AFEF \
  --color=scrollbar:-1 \
  --color=separator:#FF9E64 \
  --color=spinner:#61AFEF
set -gx EXA_COLORS "da=0;37:uu=0;37:tr=38;5;011:gu=0;37:ur=38;5;011:gr=38;5;011:sn=38;5;011:sb=38;5;011"
set -x GPG_TTY (tty)

# Abbreviations
abbr tc "tmux attach"
abbr gs "git status"
abbr gp "git pull"
abbr gP "git push --force-with-lease"
abbr dc "docker compose"
abbr tr "tmux new-session -d && tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh && tmux attach"

# Aliases

alias grep "grep --color=auto"
alias ls "eza --color=always --icons --group-directories-first"
alias ll "eza -lg --git --icons"

alias python=python3
alias pip=pip3
alias nvim "nvim"

alias reload-setup=./.config/bspwm/bspwmrc
alias i3lock="i3lock --color=000000"

# Starship
starship init fish | source

# Direnv
direnv hook fish | source
