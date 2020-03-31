#!/bin/bash

function f_emacs_main() {
    f_out "Installing Emacs"

    sudo zypper install -y emacs 

    f_emacs_common
}
