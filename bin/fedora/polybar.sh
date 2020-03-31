#!/bin/bash

function f_polybar_main() {
    f_out "Compiling and installing Polybar"

    cd ~/.build/
    git clone --recurisve https://github.com/jaagr/polybar
    cd ~/.build/polybar/ 
    ./build.sh --all-features -g -f 
}
