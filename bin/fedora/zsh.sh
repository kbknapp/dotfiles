#!/bin/bash

function f_zsh_main() {
    f_out "Installing and setting up ZSH"

    sudo dnf install -y zsh zsh-syntax-highlighting fzf

    f_zsh_common
}
