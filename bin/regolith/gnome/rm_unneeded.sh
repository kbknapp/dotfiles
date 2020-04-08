#!/bin/bash

function f_rm_unneeded_main() {
  f_out "Removing unneeded applications"

  sudo apt remove -y gnome-mines gnome-sudoku
}
