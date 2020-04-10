#!/bin/bash

function f_os_post() {
    f_out "Finishing up Manjaro Install"

    sudo pacman -Syyuu
}
