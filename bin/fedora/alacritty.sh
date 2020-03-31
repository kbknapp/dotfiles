#!/bin/bash

function f_alacritty_main() {
    f_out "Compiling Alacritty"

    sudo dnf install -y fontconfig-devel freetype-devel libxcb-devel xcb-util-image-devel libXrender-devel

    cd ~/.build/
    git clone https://github.com/jwilm/alacritty
    cd alacritty

    cargo build --release

    f_out "Setting up Alacritty"
	sudo cp target/release/alacritty /usr/bin
    cp -r ~/.dotfiles/alacritty ~/.config/

    cd
}
