#!/bin/bash

function f_get_os_components() {
    _OS_COMPONENTS=$(dialog --checklist "Which Manjaro Components?" 400 400 5 \
	    rua "Rua AUR Helper" on \
	    yay "Yay AUR Helper" on \
	    aura "Aura AUR Helper" off \
	    pacaur "Pacaur AUR Helper" on \
        --output-fd 1)
    clear

    readonly _OS_COMPONENTS
}
