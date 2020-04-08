#!/bin/bash

function f_wireguard_main() {
    f_out "Installing setting Wireguard"

    sudo apt-add-repository ppa:wireguard/wireguard
    $INSTALL_CMD wireguard wireguard-tools
    echo wireguard | sudo tee /etc/modules-load.d/wireguard.conf
}
