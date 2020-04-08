#!/bin/bash

function f_docker_main() {
    f_out "Installing and setting up Docker"

    curl -LSs https://get.docker.io | sh
    sudo usermod -aG docker ${SCRIPT_RUN_USER}
}
