#!/bin/bash

function f_zsh_main() {
    f_out "Installing and setting up ZSH"

    sudo zypper install -y zsh fzf

    f_zsh_common
}
