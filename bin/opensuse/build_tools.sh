#!/bin/bash

function f_build_tools_main() {
    f_out "Installing build tools"

    sudo zypper install -t pattern devel_basis
    sudo zypper install llvm clang pkgconfig meson xfsprogs cmake
}
