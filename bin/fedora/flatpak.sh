#!/bin/bash

function f_flatpak_main() {
    f_out "Installing and setting up Flatpak"

    sudo dnf install -y flatpak 
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}
