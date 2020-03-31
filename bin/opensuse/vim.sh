#!/bin/bash

function f_vim_main() {
    f_out "Installing and setting up VIM"

    sudo zypper install -y vim-enhanced ctags
}
