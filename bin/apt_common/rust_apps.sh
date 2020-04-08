#!/bin/bash

function f_rust_apps_main() {
    f_out "Installing Rust applications deps"

    $INSTALL_CMD libssl-dev cmake pkg-config llvm clang llvm-dev

    f_rust_apps_common
}
