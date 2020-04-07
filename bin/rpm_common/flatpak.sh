#!/bin/bash

function f_flatpak_main() {
    f_out "Installing and setting up Flatpak"

    $INSTALL_CMD flatpak 

    f_flatpak_common
}
