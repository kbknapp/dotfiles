#!/bin/bash

function f_podman_main() {
    f_out "Installing Podman"

    sudo dnf install -y podman
}
