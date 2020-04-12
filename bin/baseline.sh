#!/bin/bash

# Exit on error
set -e

_VER="0.4.0"
_NAME=$(basename "${0}")

# CLI OPTIONS
_VERBOSE=0
_DEBUG=0
_COLOR=1
SCRIPT_RUN_USER=
DID_ERR=0
INSTALL_CMD=

# Options Set Through Use
_OS=
_DE=
_COMPONENTS=
_OS_COMPONENTS=
_DE_COMPONENTS=
_OS_COMPONENTS_FIRST=true

readonly SELF=${0##*/}
declare -A COLORS=(
  [RED]=$'\033[0;31m'
  [GREEN]=$'\033[0;32m'
  [BLUE]=$'\033[0;34m'
  [PURPLE]=$'\033[0;35m'
  [CYAN]=$'\033[0;36m'
  [WHITE]=$'\033[0;37m'
  [YELLOW]=$'\033[0;33m'
  [BOLD]=$'\033[1m'
  [OFF]=$'\033[0m'
)

function f_exit() {
  local STATUS
  STATUS=$1

  if [[ "$DID_ERR" == 1 ]]; then
    exit 1
  fi

  exit "$STATUS"
}

# Do not run this script as root, we use sudo for priv cmds
if [[ $EUID == 0 ]]; then
  echo >&2 "${COLORS[RED]}error${COLORS[OFF]}: Do not run this script as root"
  exit 1
fi

function print_help() {
	cat << EOF
${_NAME}
A script to setup a common work environment

OPTIONS:
    --help      show this message
    --version	show version information

EOF
}

# Cannot be in a function due to looping through CLI values
for arg in "$@"; do
  case "$arg" in
    --no-color)
      COLOR=0
      ;;
    *)
      continue
      ;;
  esac
done

for arg in "$@"; do
  if [[ "$SKIP" == 1 ]]; then
    SKIP=0
    continue
  fi
  case $arg in
    -h|--help)
      print_help
      exit 0
      ;;
    -V|--version)
      echo -e "$NAME v$VER"
      exit 0
      ;;
    --no-color)
      continue
      ;;
    -v|--verbose)
      VERBOSE=1
      ;;
    --debug)
      DEBUG=1
      ;;
  esac
done

function f_os_components() {
  for COM in ${_OS_COMPONENTS[@]}; do
      if type f_${COM}_pre 2>/dev/null; then
          f_${COM}_pre
      fi
      if type f_${COM}_main 2>/dev/null; then
          f_${COM}_main
      else
          f_out "${COM} isn't supported with this OS/DE combo"
      fi
      if type f_${COM}_post 2>/dev/null; then
          f_${COM}_post
      fi
  done
}

function main {
  # CLI Vars
  readonly _VERBOSE
  readonly _COLOR
  readonly _DEBUG

	echo "############################"
	echo "## Kustom Baseline v${_VER}"
	echo "############################"

  source ./common/00_pre.sh
  # shellcheck disable=1090
  for s in ./common/*; do
    [[ -e $s ]] || break
    # don't resource 00_ scripts
    S_NAME=$(basename $s)
    [[ "${S_NAME:0:2}" == "00" ]] && continue

    source "$s"
  done

  f_pre_main
  f_get_os
  f_get_de

  f_get_common_components

  for s in $(find ./${_OS}/ -maxdepth 1 -type f); do
    [[ -e $s ]] || break
    S_NAME=$(basename $s)
    source "$s"
  done

  for s in ./${_OS}/${_DE}/*; do
    [[ -e $s ]] || break
    S_NAME=$(basename $s)
    source "$s"
  done

  f_os_pre
  f_get_os_components

  if $_OS_COMPONENTS_FIRST ;then
	  f_os_components
  fi

  for COM in ${_COMPONENTS[@]}; do
      if type f_${COM}_pre 2>/dev/null; then
          f_${COM}_pre
      fi
      if type f_${COM}_main 2>/dev/null; then
          f_${COM}_main
      else
          f_out "${COM} isn't supported with this OS/DE combo"
      fi
      if type f_${COM}_post 2>/dev/null; then
          f_${COM}_post
      fi
  done

  if ! $_OS_COMPONENTS_FIRST ;then
	  f_os_components
  fi

  f_get_de_components
  f_de_pre

  for COM in ${_DE_COMPONENTS[@]}; do
      if type f_${COM}_pre 2>/dev/null; then
          f_${COM}_pre
      fi
      if type f_${COM}_main 2>/dev/null; then
          f_${COM}_main
      else
          f_out "${COM} isn't supported with this OS/DE combo"
      fi
      if type f_${COM}_post 2>/dev/null; then
          f_${COM}_post
      fi
  done

  f_de_post
  f_os_post
  f_post
}

LOGFILE="./${_NAME}-$(hostname --short)-$(date +%Y%m%d).log"
echo "[BASELINE LOG - $(hostname --fqdn) - $(LANG=C date)]" >> "$LOGFILE"

main "$@" 2>&1 | tee >(sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" >> "$LOGFILE")

f_exit 0
