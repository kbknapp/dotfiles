#!/bin/bash

function f_build_tools_main() {
    f_out "Installing build tools"

    sudo dnf install -y @development-tools gcc make llvm clang pkgconfig cmake \
        gcc-c++ automake meson 
}
