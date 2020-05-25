#!/bin/bash

function f_get_de_components() {
    _DE_COMPONENTS=$(dialog --checklist "Which DE Components?" 400 400 5 \
       i3_gaps "i3 Gaps" on \
       ksuperkey "KSuperKey" on \
       picom "Picom" on \
       polybar "Polybar" off \
       rm_unneeded_i3k "Remove Unneeded KDE Apps" on \
        --output-fd 1)
    clear

    readonly _DE_COMPONENTS
}
