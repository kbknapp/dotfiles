#!/bin/bash

function f_neovim_main() {
    f_out "Installing and setting up NeoVIM"

    sudo zypper install -y neovim python3-neovim fzf ctags

    f_neovim_common
}
