#!/bin/bash

function f_vlc_main() {
    f_out "Installing VLC"

    sudo dnf install -y vlc
}
