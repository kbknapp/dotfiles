#!/bin/bash

function f_polybar_main() {
    f_check_prog "git"
    f_check_prog "make"

    f_out "Installing Polybar Build Deps"

    $INSTALL_CMD libcairo2-dev libasound2-dev libcurl4-openssl-dev \
      libmpdclient-dev libiw-dev libpulse-dev libxcb-composite0-dev \
      xcb-proto libxcb-icccm4-dev libxcb-ewmh-dev libxcb-util-dev \
      python3-xcbgen libjsoncpp-dev

    f_out "Compiling and installing Polybar"

    cd ~/.build/
    git clone --recursive https://github.com/jaagr/polybar || true
    cd ~/.build/polybar/
    ./build.sh --all-features -g -f
    cp -r ~/.dotfiles/polybar ~/.config
}
