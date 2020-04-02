#!/bin/bash

function f_mailspring_main() {
    f_check_prog "snap"

    f_out "Installing Mailspring"

    sudo snap install mailspring
}

function f_lxd_main() {
    f_check_prog "snap"

    f_out "Installing LXD"

    sudo snap install lxd
}

function f_clion_main() {
    f_check_prog "snap"

    f_out "Installing Clion"

    sudo ln -s /var/lib/snapd/snap /snap
    sudo snap install clion --classic
}


function f_freemind_main() {
    f_check_prog "snap"

    f_out "Installing FreeMind"

    sudo snap install freemind
}

function f_snap_apps_main() {
    local _SNAP_COMPONENTS

    _SNAP_COMPONENTS=$(dialog --checklist "Which Snap Apps?" 400 400 4 \
       lxd "LXD" on \
       clion Clion on \
       mailspring Mailspring on \
       freemind FreeMind on \
        --output-fd 1)
    clear

    readonly _SNAP_COMPONENTS

    for COM in ${_SNAP_COMPONENTS[@]}; do
        f_${COM}_main
    done
}
