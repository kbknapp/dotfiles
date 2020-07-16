#!/bin/bash

function f_alacritty_main() {
    f_out "Installing alacritty deps"

    $INSTALL_CMD fontconfig libfreetype-dev libxcb1-dev \
	    libxcb-image0-dev libxcb-randr0-dev libxcb-image0-dev \
	    libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev \
      libfontconfig-dev

    f_alacritty_common
}
