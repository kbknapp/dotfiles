#!/bin/bash

function f_alacritty_common() {
    if [ -e ~/.cargo/env ]; then
	    source ~/.cargo/env
    fi
    f_check_prog "cargo"
    f_check_prog "git"

    f_out "Compiling alacritty"
    cd ~/.build/
    git clone https://github.com/alacritty/alacritty || true
    cd alacritty

    cargo build --release

    f_out "Setting up Alacritty"
	sudo cp target/release/alacritty /usr/bin
    cp -r ~/.dotfiles/alacritty ~/.config/

    cd
}
