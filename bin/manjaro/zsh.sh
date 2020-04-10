#!/bin/bash

function f_zsh_main() {
    f_out "Installing and setting up ZSH"

    $INSTALL_CMD zsh zsh-syntax-highlighting fzf

    f_zsh_common
}
