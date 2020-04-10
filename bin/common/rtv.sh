#!/bin/bash

function f_rtv_main() {
  f_check_prog "pip3" false || f_check_prog "pip"

  f_out "Installing RTV"

  pip3 install --user --upgrade rtv || pip install --user --upgrade rtv
}
