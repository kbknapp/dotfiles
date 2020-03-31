#!/bin/bash

function f_rust_main {
    f_check_prog "curl"

    f_out "Installing and setting up Rust"

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source ~/.cargo/env
    rustup default nightly
    rustup component add rust-src
}
