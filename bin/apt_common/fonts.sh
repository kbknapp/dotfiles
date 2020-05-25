#!/bin/bash

function f_fonts_main() {
    f_out "Installing fonts"

    # 20.04 does not have fonts-source-code-pro-ttf
    $INSTALL_CMD fonts-firacode fonts-font-awesome
}
