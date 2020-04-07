#!/bin/bash

function f_get_os_components() {
    _OS_COMPONENTS=$(dialog --checklist "Which OpenSUSE Components?" 400 400 2 \
       packman "Packman Repo" on \
       media "Media Repo" on \
        --output-fd 1)

    readonly _OS_COMPONENTS
}
