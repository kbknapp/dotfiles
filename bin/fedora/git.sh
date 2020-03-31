#!/bin/bash

function f_git_main() {
    f_out "Installing git and git related tools"

    sudo dnf install -y git gitg tig 

    f_git_common
}
