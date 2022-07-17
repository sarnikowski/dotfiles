export ZSH="$HOME/.oh-my-zsh"
source ~/.config/zsh/.zshrc
# Swap caps and control
/usr/bin/setxkbmap -option "ctrl:nocaps"
# Add extra character mappings
xmodmap -e "keycode 52 = z Z z Z backslash backslash"
xmodmap -e "keycode 59 = comma semicolon comma semicolon less less"
xmodmap -e "keycode 60 = period colon period colon greater greater"
xmodmap -e "keycode 21 = acute grave acute grave bar bar"
xmodmap -e "keycode 35 = acute asciicircum acute asciicircum asciitilde asciitilde"
source ~/commands.sh
