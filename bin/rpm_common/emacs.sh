#!/bin/bash

function f_emacs_main() {
    f_out "Installing Emacs"

    $INSTALL_CMD emacs 

    f_emacs_common
}
