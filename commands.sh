#!/bin/bash

function install-lsps() {
	sudo npm install -g pyright
	sudo npm install -g dockerfile-language-server-nodejs
	sudo npm install -g vscode-json-languageserver
	sudo npm install -g yaml-language-server
	sudo npm install -g bash-language-server
	sudo npm install -g typescript
	sudo npm install -g typescript-language-server
	sudo npm install -g eslint
	sudo npm install -g prettier
	sudo npm install -g vls

	go install golang.org/x/tools/gopls@latest
}

function update-nvim() {
	neovim_path="/home/$(whoami)/neovim"
	(cd $neovim_path && sudo rm -rf build && make clean)
	(cd $neovim_path && git pull && sudo make CMAKE_BUILD_TYPE=Release install)
	install-lsps
}

function lock() {
	IMAGE=/tmp/i3lock.png
	SCREENSHOT="scrot $IMAGE"
	BLURTYPE="0x5"
	# Get the screenshot, add the blur and lock the screen with it
	$SCREENSHOT
	convert $IMAGE -blur $BLURTYPE $IMAGE
	i3lock -i $IMAGE
	rm $IMAGE
}
