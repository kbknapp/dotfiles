#!/bin/bash

function f_polybar_main() {
    f_out "Compiling and installing Polybar"

    cd ~/.build/
    cd ~/.build/polybar/ 
    ./build.sh --all-features -g -f 
    git clone --recurisve https://github.com/jaagr/polybar || true
}
