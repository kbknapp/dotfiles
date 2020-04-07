#!/bin/bash

function f_rust_apps_main() {
    f_out "Installing Rust applications deps"

    $INSTALL_CMD openssl-devel cmake pkg-config

    f_rust_apps_common
}
