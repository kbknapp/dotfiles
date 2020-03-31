#!/bin/bash

function f_fonts_main() {
    f_out "Installing fonts"

    # @TODO add fontawesome
    sudo dnf install -y 'mozilla-fira-*' fira-code-fonts adobe-source-code-pro-fonts
}
