#!/bin/bash

function f_steam_main() {
  f_out "Installing Steam"

  sudo zypper addrepo https://download.opensuse.org/repositories/standard/openSUSE:Factory:NonFree.repo
  sudo zypper install -y steam
}
