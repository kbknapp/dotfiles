#!/bin/bash

function f_polybar_main() {
    f_check_prog "git"
    f_check_prog "make"

    f_out "Compiling and installing Polybar"

    cd ~/.build/
    git clone --recursive https://github.com/jaagr/polybar || true
    cd ~/.build/polybar/
    ./build.sh --all-features -g -f
    cp -r ~/.dotfiles/polybar ~/.config
}
