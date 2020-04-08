#!/bin/bash

function f_amdgpu_main() {
  f_out "Adding the AMD GPU PPA"
  sudo add-apt-repository ppa:oibaf/graphics-drivers
  sudo apt update
  sudo apt upgrade -y
}
