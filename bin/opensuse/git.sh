#!/bin/bash

function f_git_main() {
    f_out "Installing git tools"

    sudo zypper install -y git gitg tig 

    f_git_common
}
