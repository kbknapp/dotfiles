#!/bin/bash

function f_steam_main() {
  f_out "Installing Steam"

  sudo dnf install -y steam
}
