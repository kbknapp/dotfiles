#!/bin/bash

function f_build_tools_main() {
    f_out "Installing build tools"

    sudo zypper install -y -t pattern devel_basis
    sudo zypper install -y llvm clang pkgconfig meson xfsprogs cmake
}
