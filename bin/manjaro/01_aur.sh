#!/bin/bash

function f_aur_install() {
	local _pkg
	_pkg=$1
	f_check_prog "git"

	f_out "Installing ${_pkg} from the AUR"

	cd ~/.build
	rm -rf ~/.build/${_pkg}
	git clone https://aur.archlinux.org/${_pkg}.git
	cd ~/.build/${_pkg}
	makepkg -si
	cd ~
}
