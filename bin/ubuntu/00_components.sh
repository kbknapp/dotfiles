#!/bin/bash

function f_get_os_components() {
    clear
    _OS_COMPONENTS=$(dialog --checklist "Which OS Components?" 400 400 1 \
       yubikey "YubiKey" on \
        --output-fd 1)
    clear

    readonly _OS_COMPONENTS
}
