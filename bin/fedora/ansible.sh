#!/bin/bash

function f_ansible_main() {
    f_out "Installing and setting up Ansible"

    sudo dnf install -y ansible
}
