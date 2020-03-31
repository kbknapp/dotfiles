#!/bin/bash

function f_rust_apps_main() {
    f_out "Installing Rust applications"

    sudo dnf install -y openssl-devel cmake pkg-config
    source ~/.dotfiles/rust/cargo_install/install_apps
}
