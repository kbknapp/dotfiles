#!/bin/bash

function f_snapd_main() {
    f_out "Installing and setting up Snapd"

    $INSTALL_CMD squashfuse snapd
    sudo systemctl enable --now snapd.socket
    if [ ! -e /snap ]; then
	    sudo ln -s /var/lib/snapd/snap /snap
    fi
}
