#!/bin/bash

function f_qemu_main() {
    f_check_prog "snap"

    f_out "Installing Mailspring"

    sudo snap install qemu-virgil --edge
    sudo snap connect qemu-virgil:kvm
    sudo snap connect qemu-virgil:raw-usb
    sudo snap connect qemu-virgil:removable-media
}

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

    if [ ! -e /snap ]; then
	    sudo ln -s /var/lib/snapd/snap /snap
    fi
    sudo snap install clion --classic
}


function f_freemind_main() {
    f_check_prog "snap"

    f_out "Installing FreeMind"

    sudo snap install freemind
}

function f_snap_apps_main() {
    local _SNAP_COMPONENTS

    _SNAP_COMPONENTS=$(dialog --checklist "Which Snap Apps?" 400 400 5 \
       lxd "LXD" off \
       clion Clion off \
       mailspring Mailspring on \
       freemind FreeMind off \
       qemu "QEMU-Virgil" off \
        --output-fd 1)
    clear

    readonly _SNAP_COMPONENTS

    for COM in ${_SNAP_COMPONENTS[@]}; do
        f_${COM}_main
    done
}
