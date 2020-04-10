#!/bin/bash

function f_check_root() {
  f_verb_out "(PRE) checking root privileges"

  sudo whoami >/dev/null 2>&1
  # shellcheck disable=SC2181
  if [[ "$?" != 0 ]]; then
    f_err_out "Not root or not enough privileges."
    f_exit 1
  fi
}

function f_check_bash() {
  f_verb_out "(PRE) Checking Bash"
  readlink "/proc/$$/exe" | grep -si bash >/dev/null 2>&1

  # shellcheck disable=SC2181
  if [[ "$?" != 0 ]]; then
    f_err_out "this script must be run with bash e.g. 'bash $NAME'"
    f_exit 1
  fi
}

function f_check_prog() {
    local prog
    local should_exit
    prog=$1
    should_exit=true
    if [ ! -z $2 ]; then
	    should_exit=$2
    fi

  if ! command -v "${prog}" >/dev/null; then
    if $should_exit ; then
      f_err_out "this script requires the program '${prog}'"
      f_exit 1
    fi
  fi
}

function f_check_programs() {
  f_verb_out "(PRE) Checking for required programs"

  f_check_prog "dialog"
}

function f_dbg_out() {
  local IDENT
  local MSG
  MSG=$1
  IDENT=$2
  if [[ "$DEBUG" == 1 ]]; then
    if [[ ! -z "$IDENT" ]]; then
      for _ in {0.."$IDENT"}; do
        echo -n "${COLORS[YELLOW]}${COLORS[BOLD]}~"
      done
    fi
    eval "$DEBUG_PREFIX"
    echo " $MSG"
  fi
}

function f_verb_out() {
  local IDENT
  local MSG
  MSG=$1
  IDENT=$2
  if [[ "$VERBOSE" == 1 ]]; then
    if [[ ! -z "$IDENT" ]]; then
      for _ in {0.."${IDENT}"}; do
        echo -n "${COLORS[WHITE]}${COLORS[BOLD]}="
      done
    fi
    eval "$VERB_PREFIX"
    echo " $MSG"
  fi
}

function f_out() {
  local IDENT
  local MSG
  MSG=$1
  IDENT=$2
  if [[ ! -z "$IDENT" ]]; then
    for _ in {0.."${IDENT}"}; do
      echo -n "${COLORS[GREEN]}${COLORS[BOLD]}-"
    done
  fi
  eval "$ECHO_PREFIX"
  echo " $MSG"
}

function f_err_out() {
  eval "$ERR_PREFIX" >&2
  echo >&2 " $1"
}

function f_set_script_run_user() {
  SCRIPT_RUN_USER=$(sudo pstree -lu -s $$ | grep --max-count=1 -o '([^)]*)' | head -n 1 | sed 's/[()]//g')
  f_verb_out "(PRE) Setting script run user as ${COLORS[YELLOW]}$SCRIPT_RUN_USER${COLORS[OFF]}"
  readonly SCRIPT_RUN_USER
}

function f_pre_main() {
  HOST_NAME=$(hostname)
  ECHO_PREFIX='printf "${COLORS[GREEN]}${COLORS[BOLD]}->${COLORS[OFF]}"'
  ERR_PREFIX='printf "${COLORS[RED]}error${COLORS[OFF]}:"'
  VERB_PREFIX='printf "${COLORS[WHITE]}${COLORS[BOLD]}=>${COLORS[OFF]}"'
  DEBUG_PREFIX='printf "${COLORS[YELLOW]}${COLORS[BOLD]}~>${COLORS[OFF]}"'

  readonly ECHO_PREFIX
  readonly ERR_PREFIX

  f_check_root
  f_check_bash
  f_check_programs
  #f_check_ubuntu
  f_set_script_run_user
}
