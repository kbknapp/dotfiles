#!/bin/bash

function f_validate_de() {
    case "${_OS}" in
        regolith)
            case "${_DE}" in
                i3g)
                    return 0
                ;;
                *)
                    return 1
                ;;
            esac
            ;;
        ubuntu)
            case "${_DE}" in
                gnome|kde|xfce|i3x|i3g|i3k)
                    return 0
                ;;
                *)
                    return 1
                ;;
            esac
            ;;
        fedora)
            case "${_DE}" in
                i3k)
                    return 0
                    ;;
                *)
                    return 1
                    ;;
            esac
            ;;
        manjaro)
            case "${_DE}" in
                i3k)
                    return 0
                    ;;
                *)
                    return 1
                    ;;
            esac
            ;;
        opensuse)
            case "${_DE}" in
                kde|i3k)
                    return 0
                    ;;
                *)
                    return 1
                    ;;
            esac
            ;;
        arch)
            case "${_DE}" in
                *)
                    return 1
                ;;
            esac
            ;;
        *)
            return 1
            ;;
    esac
}

function f_get_de() {
    _DE=$(dialog --radiolist "Which DE?" 200 200 6 \
        gnome Gnome off \
        kde KDE off \
        xfce XFCE off \
        i3x "i3 (XFCE)" off \
        i3k "i3 (KDE)" off \
        i3g "i3 (Gnome)" off \
        --output-fd 1)

    f_validate_de || (clear; f_err_out "${_OS} and ${_DE} is unsupported at this time" && f_exit 1)

    readonly _OS
}
