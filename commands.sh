#!/bin/bash

function update-nvim() {
	neovim_path="/home/$(whoami)/neovim"
	(cd $neovim_path && sudo rm -rf build && make clean)
	(cd $neovim_path && git pull && sudo make CMAKE_BUILD_TYPE=RelWithDebInfo install)
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
