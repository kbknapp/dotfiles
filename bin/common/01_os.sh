#!/bin/bash

function f_validate_os() {
    case "${_OS}" in
        fedora|opensuse|regolith|manjaro|ubuntu)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}
function f_get_os() {
    _OS=$(dialog --radiolist "Which OS Family?" 200 200 5 \
        regolith Regolith on \
        fedora Fedora off \
        manjaro Manjaro off \
        opensuse OpenSUSE off \
        ubuntu Ubuntu off \
        --output-fd 1)
    clear

    f_validate_os || (clear; f_err_out "${_OS} is unsupported at this time" && f_exit 1)
    readonly _OS
}
