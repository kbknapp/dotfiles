#!/bin/bash

function f_validate_os() {
    case "${_OS}" in
        ubuntu|fedora|opensuse)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}
function f_get_os() {
    _OS=$(dialog --radiolist "Which OS Family?" 200 200 4 \
        ubuntu Ubuntu on \
        fedora Fedora off \
        opensuse OpenSUSE off \
        arch Arch off \
        --output-fd 1)
    clear

    f_validate_os || (f_err_out "${_OS} is unsupported at this time" && f_exit 1)
    readonly _OS
}
