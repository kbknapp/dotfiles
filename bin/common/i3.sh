#!/bin/bash

function f_i3_gaps_main() {
    f_check_prog "git"
    f_check_prog "make"

    f_out "Compiling and Installing i3-gaps"

    cd ~/.build/
    git clone --recursive https://github.com/Airblader/i3 || true

    cd ~/.build/i3/
    autoreconf --force --install
    mkdir -p build
    cd build/
    ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
    make -j16
    sudo make install
}
