#!/bin/bash

function f_rtv_main() {
  f_check_prog "pip3"

  f_out "Installing RTV"

  pip3 install --user --upgrade rtv
}
