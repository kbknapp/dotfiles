#!/bin/bash

function f_alacritty_common() {
    f_check_prog "cargo"
    f_check_prog "git"

    f_out "Compiling alacritty"
    cd ~/.build/
    git clone https://github.com/jwilm/alacritty || true
    cd alacritty

    cargo build --release

    f_out "Setting up Alacritty"
	sudo cp target/release/alacritty /usr/bin
    cp -r ~/.dotfiles/alacritty ~/.config/

    cd
}
