#!/bin/bash

function f_de_post() {
    f_out "Finalizing i3 (Gnome) Setup"

    for COM in ${_DE_COMPONENTS[@]}; do
        if type f_${COM}_post; then
            f_${COM}_post
        fi
    done
}
