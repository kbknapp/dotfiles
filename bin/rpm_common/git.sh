#!/bin/bash

function f_git_main() {
    f_out "Installing git and git related tools"

    $INSTALL_CMD git gitg tig 

    f_git_common
}
