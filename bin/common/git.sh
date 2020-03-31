#!/bin/bash

function f_git_common() {
    f_out "Setting up git"

    cat <<EOF > ~/.gitconfig
[user]
	email = kbknapp@gmail.com
	name = Kevin K.
	signingkey = 17218E4B3692F01A
[color]
	ui = true
[rebase]
	autosquash = true
[commit]
	gpgsign = true
EOF
    
}
