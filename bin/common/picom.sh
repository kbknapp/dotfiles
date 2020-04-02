#!/bin/bash

function f_picom_main() {
    f_check_prog "git"
    f_check_prog "meson"
    f_check_prog "ninja"

    f_out "Compiling and installing Picom"

    cd ~/.build/
    git clone --recursive https://github.com/yshui/picom || true
    cd ~/.build/picom/
    git submodule update --init --recursive
    meson --buildtype=release . build
    ninja -C build
    sudo ninja -C build install
}

