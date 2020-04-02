#!/bin/bash

function f_os_post() {
    f_out "Finishing up Fedora Install"

    sudo dnf clean all
    sudo dnf upgrade -y --best --allowerasing
}
