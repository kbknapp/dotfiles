#!/bin/bash

function f_os_pre() {
    f_out "(PRE) Running OS pre-script"

    INSTALL_CMD='sudo zypper install -y'

    for s in ./rpm_common/*; do
        [[ -e $s ]] || break
        S_NAME=$(basename $s)
        source "$s"
    done
}
