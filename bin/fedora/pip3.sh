#!/bin/bash

function f_pip3_main() {
    f_out "Installing setting Pip3"

    sudo dnf install -y python3-pip
}
