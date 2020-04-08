#!/bin/bash

function f_build_tools_main() {
    f_out "Installing build tools"

    $INSTALL_CMD build-essential gcc make llvm clang pkg-config cmake \
        automake libssl-dev
}
