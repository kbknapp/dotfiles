#!/bin/bash

function f_rust_apps_common() {
   if [ -e ~/.cargo/env ]; then
        source ~/.cargo/env
    fi
    f_check_prog "cargo"

    f_out "Compiling and installing Rust applications"

    source ~/.dotfiles/rust/cargo_install/install_apps
}

function f_rust_main {
    f_check_prog "curl"

    f_out "Installing and setting up Rust"

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source ~/.cargo/env
    rustup default nightly
    rustup component add rust-src
}
