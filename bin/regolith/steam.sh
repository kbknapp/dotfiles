#!/bin/bash

function f_steam_main() {
  f_out "Installing Steam"

  sudo add-apt-repository multiverse
  sudo apt update

  $INSTALL_CMD steam
}
