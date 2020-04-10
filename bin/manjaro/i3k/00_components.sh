#!/bin/bash

function f_get_de_components() {
    _DE_COMPONENTS=$(dialog --checklist "Which DE Components?" 400 400 5 \
	    i3_gaps "i3 Gaps (Manual Build)" off \
	    i3_gaps_aur "i3 Gaps (AUR Build)" on \
	    ksuperkey "KSuperKey" on \
	    picom "Picom (Manual Build)" off \
	    picom_aur "Picom (AUR Build)" on \
	    polybar "Polybar" off \
	    rm_unneeded_i3k "Remove Unneeded KDE Apps" on \
        --output-fd 1)
    clear

    readonly _DE_COMPONENTS
}
