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

    sudo snap install clion --classic
}


function f_freemind_main() {
    f_check_prog "snap"

    f_out "Installing FreeMind"

    sudo snap install freemind
}
