#!/bin/bash

function f_intel_undervolt_main() {
    f_check_prog "git"
    f_check_prog "make"

    f_out "Compiling and setting up Intel Undervolt"

    cd ~/.build/
    git clone https://github.com/kitsunyan/intel-undervolt || true
    cd intel-undervolt/
    ./configure --enable-systemd
    make
    sudo make install
    sudo cp ${HOME}/.dotfiles/intel-undervolt/intel-undervolt.conf /etc/
    sudo systemctl enable intel-undervolt
}
