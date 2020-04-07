#!/bin/bash

function f_os_post_main() {
    f_out "Finishing up OpenSUSE Install"

    sudo zypper dup --allow-vender-change
}
