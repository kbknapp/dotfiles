#!/bin/bash

function f_neovim_main() {
    f_check_prog "curl"

    f_out "Installing NeoVIM"

    sudo dnf install -y neovim python3-neovim fzf ctags

    f_neovim_common
}
