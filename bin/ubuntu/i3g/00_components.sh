#!/bin/bash

function f_get_de_components() {
    _DE_COMPONENTS=$(dialog --checklist "Which DE Components?" 400 400 5 \
       polybar "Polybar" off \
        --output-fd 1)
    clear

    readonly _DE_COMPONENTS
}
