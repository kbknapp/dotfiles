#!/bin/bash

function f_fedora_post_main() {
    f_out "Finishing up Fedora Install"

    sudo zypper dup --allow-vender-change
}
