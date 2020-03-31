#!/bin/bash

function f_wireguard_main() {
    f_out "Installing setting Wireguard"

    sudo zypper addrepo -f obs://network:vpn:wireguard wireguard
    sudo zypper install wireguard-kmp-default wireguard-tools
}
