#!/bin/bash

function f_fonts_main() {
    f_out "Installing fonts"

    # @TODO add fira-code
    sudo zypper install -y fontawesome-fonts fontawesome-fonts-web \
        adobe-sourcecodepro-fonts
}
