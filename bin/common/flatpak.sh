#!/bin/bash

function f_flatpak_apps_main() {
    f_out "Installing Flatpak applications"

    source ~/.dotfiles/flathub/install_apps
}

function f_flatpak_common() {
    f_out "Installing flathub"

    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}
