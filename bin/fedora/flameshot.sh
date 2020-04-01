#!/bin/bash

function f_flameshot_main() {
    f_out "Installing Flameshot"

    sudo dnf install -y flameshot 
}
