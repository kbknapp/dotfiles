#!/bin/bash

function f_wireguard_main() {
    f_out "Installing setting Wireguard"

    sudo dnf install -y wireguard
}
