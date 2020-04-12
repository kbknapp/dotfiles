#!/bin/bash

function f_os_pre() {
    _OS_COMPONENTS_FIRST=false

    f_out "(PRE) Running OS pre-script"

    INSTALL_CMD='sudo pacman -S --needed --noconfirm'

    f_out "Upgrading the system first"

    sudo pacman -Syyu --needed --noconfirm

    for s in ./arch_common/*; do
        [[ -e $s ]] || break
        S_NAME=$(basename $s)
        source "$s"
    done
}
