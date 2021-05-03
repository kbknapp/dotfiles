#!/usr/bin/env bash

# Simple CLI for shell-color-scripts

DIR_COLORSCRIPTS="${HOME}/.dotfiles/color-scripts/"
LS_CMD="$(command -v ls)"
fmt_help="  %-20s\t%-54s\n"
list_colorscripts="$($LS_CMD "${DIR_COLORSCRIPTS}" | cut -d ' ' -f 1 | nl)"
length_colorscripts="$($LS_CMD "${DIR_COLORSCRIPTS}" | wc -l)"
function _help() {
    echo "Description: A collection of terminal color scripts."
    echo ""
    echo "Usage: colorscript [OPTION] [SCRIPT NAME/INDEX]"
    printf "${fmt_help}" \
        "-h, --help, help" "Print this help." \
        "-l, --list, list" "List all installed color scripts." \
        "-r, --random, random" "Run a random color script." \
        "-e, --exec, exec" "Run a specified color script by SCRIPT NAME or INDEX."
}


# ANSI Color -- use these variables to easily have different color
#    and format output. Make sure to output the reset sequence after
#    colors (f = foreground, b = background), and use the 'off'
#    feature for anything you turn on.
# Author: Ivo
# Source: http://crunchbang.org/forums/viewtopic.php?pid=134749#p134749
function initializeANSI() {
  export esc=""

  export blackf="${esc}[30m";   export redf="${esc}[31m";    export greenf="${esc}[32m"
  export yellowf="${esc}[33m"   export bluef="${esc}[34m";   export purplef="${esc}[35m"
  export cyanf="${esc}[36m";    export whitef="${esc}[37m";   export whitef="${esc}[37m"

  export blackb="${esc}[40m";   export redb="${esc}[41m";    export greenb="${esc}[42m"
  export yellowb="${esc}[43m"   export blueb="${esc}[44m";   export purpleb="${esc}[45m"
  export cyanb="${esc}[46m";    export whiteb="${esc}[47m"

  export boldon="${esc}[1m";    export boldoff="${esc}[22m"
  export italicson="${esc}[3m"; export italicsoff="${esc}[23m"
  export ulon="${esc}[4m";      export uloff="${esc}[24m"
  export invon="${esc}[7m";     export invoff="${esc}[27m"

  export reset="${esc}[0m"
}

function unsetANSI() {
  unset esc;

  unset blackf;   unset redf;    unset greenf;
  unset yellowf;   unset bluef;   unset purplef;
  unset cyanf;    unset whitef;   unset whitef;

  unset blackb;   unset redb;    unset greenb;
  unset yellowb;   unset blueb;   unset purpleb;
  unset cyanb;    unset whiteb;

  unset boldon;    unset boldoff;
  unset italicson; unset italicsoff;
  unset ulon;      unset uloff;
  unset invon;     unset invoff;

  unset reset;
}

function _list() {
    echo "There are "$($LS_CMD "${DIR_COLORSCRIPTS}" | wc -l)" installed color scripts:"
    echo "${list_colorscripts}"
}

function _random() {
    cs=$(find "${DIR_COLORSCRIPTS}" -type f | shuf | head -1)
    initializeANSI
    source "${cs}"
}

function ifhascolorscipt() {
    [[ -e "${DIR_COLORSCRIPTS}/$1" ]] && echo "Has this color script."
}

function _run_by_name() {
    if [[ "$1" == "random" ]]; then
        _random
    elif [[ -n "$(ifhascolorscipt "$1")" ]]; then
        exec "${DIR_COLORSCRIPTS}/$1"
    else
        echo "Input error, Don't have color script named $1."
        exit 1
    fi
}

function _run_by_index() {
    if [[ "$1" -gt 0 && "$1" -le "${length_colorscripts}" ]]; then

        colorscript="$(echo  "${list_colorscripts}" | sed -n ${1}p \
            | tr -d ' ' | tr '\t' ' ' | cut -d ' ' -f 2)"
        exec "${DIR_COLORSCRIPTS}/${colorscript}"
    else
        echo "Input error, Don't have color script indexed $1."
        exit 1
    fi
}

function _run_colorscript() {
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        _run_by_index "$1"
    else
        _run_by_name "$1"
    fi
}

case "$#" in
    0)
        _help
        ;;
    1)
        case "$1" in
            -h | --help | help)
                _help
                ;;
            -l | --list | list)
                _list
                ;;
            -r | --random | random)
                _random
                ;;
            *)
                echo "Input error."
                exit 1
                ;;
        esac
        ;;
    2)
        if [[ "$1" == "-e" || "$1" == "--exec" || "$1" == "exec" ]]; then
            _run_colorscript "$2"
        else
            echo "Input error."
            exit 1
        fi
        ;;
    *)
        echo "Input error, too many arguments."
        exit 1
        ;;
esac
