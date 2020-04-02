#!/bin/bash

function f_picom_main() {
    f_check_prog "git"
    f_check_prog "meson"
    f_check_prog "ninja"

    f_out "Compiling and installing Picom"

    cd ~/.build/
    cd ~/.build/picom/ 
    git submodule update --init --recursive 
    meson --buildtype=release . build 
    ninja -C build 
    git clone --recursive https://github.com/yshui/picom || true
    sudo ninja -C build install
}

