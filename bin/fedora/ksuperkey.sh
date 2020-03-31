
#!/bin/bash

function f_ksuperkey_main() {
    f_check_prog "git"
    f_check_prog "make"

    f_out "Compiling and installing KSuperKey"
    cd ~/.build/
    git clone --recurisve https://github.com/hanschen/ksuperkey
    cd ~/.build/ksuperkey/
    make 
    sudo make install
    
    cd
}
