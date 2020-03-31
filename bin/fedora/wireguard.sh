#!/bin/bash

function f_wireguard_main() {
    f_out "Installing setting Wireguard"

    sudo dnf copr enable jdoss/wireguard
    sudo dnf install wireguard-dkms wireguard-tools
}
