#!/bin/bash

function f_flatpak_main() {
    f_out "Installing Flatpak"

    sudo dnf install -y flatpak 
    f_flatpak_common
}
