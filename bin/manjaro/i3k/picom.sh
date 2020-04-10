#!/bin/bash

function f_picom_aur() {
	f_out "Installing Picom from AUR"

	if command -v rua 2>/dev/null ;then
		rua install picom-git
		return
	fi
	if command -v yay 2>/dev/null ;then
		yay -a -S picom-git
		return
	fi
	if command -v aura 2>/dev/null ;then
		sudo aura -A picom-git
	fi
}

function f_picom_post() {
    f_out "Configuring Picom"
    
    cp -r ~/.dotfiles/i3/kde/home/.config/picom/ ~/.config/
}

function f_picom_aur_post() {
	f_picome_post
}

