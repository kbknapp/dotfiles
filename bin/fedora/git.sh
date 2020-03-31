#!/bin/bash

function f_git_main() {
    f_out "Installing git tools"

    sudo dnf install -y git gitg tig 

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
