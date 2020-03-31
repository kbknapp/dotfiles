#!/bin/bash

function f_flatpak_main() {
    f_out "Installing and setting up Flatpak"

    sudo zypper install -y flatpak 

    f_flatpak_common
}
