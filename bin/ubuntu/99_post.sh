#!/bin/bash

function f_os_post() {
    f_out "Finishing up Ubuntu Install"

    sudo apt-get upgrade -y
    sudo apt-get autoremove -y
}
