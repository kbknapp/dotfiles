#!/bin/bash

function f_alacritty_main() {
    f_out "Installing alacritty deps"

    $INSTALL_CMD fontconfig freetype2 libxcb \
        xcb-util-image libxrender

    f_alacritty_common
}
