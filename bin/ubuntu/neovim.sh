#!/bin/bash

function f_neovim_main() {
    f_check_prog "curl"

    f_out "Installing NeoVIM"

    # @TODO download appimage NeoVIM
    $INSTALL_CMD fzf exuberant-ctags nodejs npm python3-neovim

    f_neovim_common
}
