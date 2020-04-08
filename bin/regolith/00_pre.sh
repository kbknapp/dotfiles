#!/bin/bash

function f_os_pre() {
    f_out "(PRE) Running OS pre-script"

    INSTALL_CMD='sudo apt-get install -y'

    for s in ./apt_common/*; do
        [[ -e $s ]] || break
        S_NAME=$(basename $s)
        source "$s"
    done
}
