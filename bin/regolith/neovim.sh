#!/bin/bash

function f_neovim_main() {
    f_check_prog "curl"

    f_out "Installing NeoVIM"

    $INSTALL_CMD neovim python3-neovim fzf exuberant-ctags

    f_neovim_common
}
