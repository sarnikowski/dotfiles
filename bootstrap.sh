#!/bin/bash
export BLUE='\033[0;34m'
export NC='\033[0m' # No Color

function print_step () {
	printf "###${BLUE}$1${NC}###\n"
}

export user=$(whoami)
#################
# Update system #
#################
print_step "Updating system"
sudo pacman -Syu
sudo pacman -S base-devel git --noconfirm

#######
# Yay #
#######
print_step "Installing yay"
git clone https://aur.archlinux.org/yay-bin.git
(cd yay-bin; makepkg -si)

###############
# Install zsh #
###############
print_step "Installing zsh"
sudo pacman -S zsh --noconfirm

print_step "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

print_step "Installing zsh plugins"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
(cd ~/.oh-my-zsh/custom/plugins; git clone https://github.com/unixorn/fzf-zsh-plugin.git fzf-zsh-plugin)
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

#################
# Install fonts #
#################
print_step "Installing nerd fonts"
mkdir -p .fonts

for f in "Gohu JetBrainsMono Arimo Noto"; do
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/${f}.zip -P /home/${user}/Downloads
	unzip /home/${user}/Downloads/${f}.zip -d /home/${user}/.fonts/
	rm /home/${user}/Downloads/${f}.zip
done

fc-cache -f -v
######################
# Alacritty terminal #
######################
print_step "Installing Alacritty terminal"
sudo pacman -S alacritty --noconfirm

##########
# Docker #
##########
print_step "Installing docker"
sudo pacman -S docker --noconfirm
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo usermod -aG docker philip
sudo pacman -S docker-compose --noconfirm

#########################
# Programming languages #
#########################
print_step "Installing go"
sudo pacman -S go --noconfirm

print_step "Installing nodejs and npm"
sudo pacman -S nodejs npm --noconfirm

print_step "Installing rustup"
sudo pacman -S rustup --noconfirm

#####################
# Window management #
#####################
print_step "Installing bspwm, sxhkd, polybar, rofi, nitrogen, dunst"
sudo pacman -S bspwm sxhkd polybar rofi nitrogen dunst --noconfirm
sudo pacman -S xdotool --noconfirm

######################
# Network management #
######################
print_step "Setting up dnsmasq"
sudo pacman -S dnsmasq --noconfirm
sudo echo -e "[main]\ndns=dnsmasq" > /etc/NetworkManager/conf.d/dns.conf
sudo cat > /etc/NetworkManager/dnsmasq.d/dnsmasq.conf <<- EOF
# Never forward plain names (without a dot or domain part)
domain-needed
# Never forward addresses in the non-routed address spaces.
bogus-priv

# Resolve *.docker names to localhost.
address=/.docker/127.0.0.1

no-resolv
# Google's nameservers.
server=8.8.8.8
server=8.8.4.4
EOF
sudo nmcli general reload

############
# Firewall #
############
print_step "Setting up firewall"
sudo pacman -S ufw --noconfirm
sudo ufw default deny incoming
sudo ufw enable

##########
# Neovim #
##########
print_step "Installing Neovim"
sudo pacman -S make cmake gcc pkgconf m4 automake autoconf --noconfirm
git clone git@github.com:neovim/neovim.git || echo "Neovim already cloned"
(cd neovim; sudo make CMAKE_BUILD_TYPE=RelWithDebInfo install)

print_step "Installing packer"
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

print_step "Installing xclip"
sudo pacman -S xclip --noconfirm

##########
# Python #
##########
print_step "Installing pip and pipx"
python -m ensurepip --upgrade
python -m pip install --user pipx

print_step "Installing Pgcli"
sudo pacman -S postgresql-libs --noconfirm
pipx install pgcli

print_step "Installing DVC"
pipx install 'dvc[s3]'

print_step "Installing black"
pipx install black

print_step "Installing isort"
pipx install isort

print_step "Installing pre-commit"
pipx install pre-commit

print_step "Installing poetry"
pipx install poetry

##############
# Kubernetes #
##############
print_step "Installing kubectl and kubectx"
sudo pacman -S kubectl kubectx --noconfirm

print_step "Installing minikube"
sudo pacman -S minikube --noconfirm

print_step "Installing helm and skaffold"
sudo pacman -S helm skaffold --noconfirm

#########
# Tools #
#########
print_step "Installing sops"
sudo pacman -S sops --noconfirm

print_step "Installing fzf"
sudo pacman -S fzf --noconfirm

print_step "Installing ripgrep"
sudo pacman -S ripgrep --noconfirm

print_step "Installing direnv"
curl -sfL https://direnv.net/install.sh | bash

print_step "Installing bat"
sudo pacman -S bat --noconfirm

print_step "Installing exa"
sudo pacman -S exa --noconfirm

print_step "Installing jq"
sudo pacman -S jq --noconfirm
#############
# Git stuff #
#############
git config --global core.excludesfile ~/.gitignore_global

#########
# Slack #
#########
git clone https://aur.archlinux.org/slack-desktop.git
(cd slack-desktop; makepkg -sri --noconfirm)

###########
# Spotify #
###########
yay -S spotify
