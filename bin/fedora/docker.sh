#!/bin/bash

function f_docker_main() {
    f_out "Installing and setting up Docker"

    sudo dnf install moby-engine docker-compose
    sudo usermod -aG docker ${SCRIPT_RUN_USER}
    
}
