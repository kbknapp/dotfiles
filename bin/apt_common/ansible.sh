#!/bin/bash

function f_ansible_main() {
    f_out "Installing and setting up Ansible"

    sudo apt-add-repository ppa:ansible/ansible
    sudo apt update
    $INSTALL_CMD ansible
}
