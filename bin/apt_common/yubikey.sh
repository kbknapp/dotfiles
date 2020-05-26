#!/bin/bash

function f_yubikey_main() {
    f_out "Installing YubiKey related packages"

    $INSTALL_CMD opensc

    sudo apt-add-repository -y ppa:yubico/stable

    $INSTALL_CMD yubico-piv-tool

    # yubico-piv-tool -a change-pin -P 123456 -N TheNewPinHere
    # yubico-piv-tool -s 9a -a generate --touch-policy=always -o public.pem
    # yubico-piv-tool -a verify-pin -P 123456 -a selfsign-certificate -s 9a -S "/CN=SSH key/" -i public.pem -o cert.pem
    # yubico-piv-tool -a import-certificate -s 9a -i cert.pem
    # ssh-keygen -D /usr/lib/x86_64-linux-gnu/opensc-pkcs11.so

    echo PKCS11Provider /usr/lib/x86_64-linux-gnu/opensc-pkcs11.so | sudo tee -a /etc/ssh/ssh_config
}
