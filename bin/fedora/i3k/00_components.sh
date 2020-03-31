#!/bin/bash

function f_get_common_components() {
    _DE_COMPONENTS=$(dialog --checklist "Which DE Components?" 400 400 4 \
       i3_gaps "i3 Gaps" on \
       ksuperkey "KSuperKey" on \
       picom "Picom" on \
       polybar "Polybar" off \
        --output-fd 1)

    readonly _DE_COMPONENTS
}
