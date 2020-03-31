#!/bin/bash

function f_os_pre() {
    f_out "(PRE) Running OS pre-script"

    sudo dnf clean all
}
