#!/bin/bash

function f_os_post() {
    f_out "Finishing up Regolith Install"

    sudo apt upgrade -y
    sudo apt autoremove -y
}
