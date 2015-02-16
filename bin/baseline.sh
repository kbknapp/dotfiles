#!/bin/bash
VERSION="0.2.0"

# Check that variables set correctly
if [ -z "$K_OS" ]; then
	k_os_settings
fi

# Helper Functions
function k_os_settings() {
	echo "Must set K_OS before running, values include:"
	echo "    ANTERGOS"
	# echo "    OSX"
	# echo "    UBUNTU"
	echo "Exiting..."
	exit 1
}

function pacman_mirror_list() {
	OLD_DIR="$(pwd)"
	cd /etc/pacman.d
	echo "Downloading the latest US mirrors..."
	sudo mv mirrorlist mirrorlist.backup
	sudo sh -c "curl -L https://www.archlinux.org/mirrorlist/\?country\=US | sed -e 's/^#Server/Server/g' > mirrorlist-us"
	echo "Sorting Arch mirrors by speed..."
	sudo sh -c "rankmirrors mirrorlist-us > mirrorlist"
	cd "$OLD_DIR"
}

function arch_update_and_upgrade(){
	echo "Updating local mirror repos..."
	sudo pacman -Syy
	echo "Peforming system upgrade..."
	sudo pacman -Syu --noconfirm
}

function arch_install_base(){
	echo "Installing base terminal applications..."
	sudo pacman -S firefox guake terminator --noconfirm
}

function arch_install_base_gui(){
	arch_install_base
	echo "Installing base GUI software..."
	sudo pacman -S firefox guake vlc terminator --noconfirm
}

function arch_install_aur_base(){
	# Install aura
	cd ~
	mkdir -p Builds
	cd Builds
	curl -Lso aura-bin.tar.gz https://aur.archlinux.org/packages/au/aura-bin/aura-bin.tar.gz
	tar xf aura-bin.tar.gz
	cd aura-bin
	makepkg -sci
	cd ..
	rm -r aura-bin
}

function arch_install_aur_base_gui(){
	arch_install_aur_base
	sudo arua -A sublime-text-dev haroopad conky-lua-nv google-chrome byobu
}

function linux_setup_home(){
	# Set up user home
	cd ~
	LOCAL_USER="$USER"
	echo "Creating required home directories..."
	mkdir -p {.tmp,.bin,Projects}
	echo "Checking for dotfiles"
	if [[ ! -d ~/.dotfiles ]]; then
		echo "Cloning dotfiles repo..."
		git clone https://github.com/kbknapp/dotfiles .dotfiles
	fi

	# Set up root home
	echo "Creating required root home directories..."
	su -
	mkdir -p {.tmp,.bin,Builds}
	ln -s /home/$LOCAL_USER/.dotfiles .dotfiles
	exit
}

function linux_setup_git(){
	echo "Configuring git..."
	git config --global user.name "Kevin K."
	git config --global user.email "kbknapp@gmail.com"
	git config --global color.ui true
}

function linux_setup_ssh_client(){
	ssh-keygen -t rsa -C "kbknapp@gmail.com"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa
}

function _linux_setup_zsh(){
	echo "Checking for oh-my-zsh..."
	if [[ ! -d ~/.oh-my-zsh ]]; then
		echo "Cloning oh-my-zsh repo"
		git clone https://github.com/robbyrussell/oh-my-zsh .oh-my-zsh
	fi
	cp .dotfiles/zsh/zshrc-linux .zshrc
	cp .dotfiles/zsh/kustom-linux.zsh-theme .oh-my-zsh/themes
	cat .dotfiles/zsh/addons/git.zshrc-addon >> .zshrc
	chsh -s "$(which zsh)" "${whoami}"
}

function linux_setup_zsh(){
	cd ~
	echo "Setting up ZSH for $USER..."
	_linux_setup_zsh
	echo "Setting up ZSH for root..."
	su -
	_linux_setup_zsh
	exit
}

function linux_gnome_startup_apps(){
	cd ~
	echo "Configuring GNOME startup applications..."
	mkdir -p .config/autostart
	cd .config/autostart
	cp ~/.dotfiles/gauke/guake.desktop ~/.config/autostart
	cp ~/.dotfiles/conky/conkybar.desktop ~/.config/autostart
}

function linux_setup_vim(){
	# Setting up vim for user
	cd ~
	echo "Setting up vim for $USER..."
	ln -s .dotfiles/vim .vim
	ln -s .vim/vimrc-linux .vimrc
	cd .vim/bundle
	git clone https://github.com/gmarik/Vundle.vim
	vim -c ":PluginInstall | qa"

	# Setting up vim for root
	echo "Setting up vim for root..."
	su -
	ln -s .dotfiles/vim .vim
	ln -s .vim/vimrc-linux .vimrc
	exit

}

function linux_setup_conky(){
	cd ~/.config
	git clone https://github.com/kbknapp/conkybar.git conky
}

# Setting up Go
# cd ~
# mkdir -p .go/{bin,src/github.com,pkg}
# export GOPATH=$HOME/.go
# Used for stale packages in Go 1.3.1
# sudo go install std
# go get code.google.com/p/go.tools/cmd/goimports

# Setting up Rust
# cd ~
# mkdir -p Projects/rust-nightlies
# mkdir -p .rust/{bin,pkg,src/github.com}
# cd ~/Projects/rust-nightlies
# curl -LSso rustup.sh https://static.rust-lang.org/rustup.sh
# chmod +x rustup.sh
# sudo ./rustup.sh

echo "############################"
echo "## Kustom Baseline v$VERSION"
echo "############################"
echo

case "$K_OS" in
	ANTERGOS)
		echo "OS set to $K_OS..."
		
		# Set up mirror lists
		echo "Enabling [multilib] repos..."
		sudo sh -c "echo \"[multilib]\" >> /etc/pacman.conf"
		sudo sh -c "echo \"Include = /etc/pacman.d/mirrorlist\" >> /etc/pacman.conf"

		pacman_mirror_list
		
		echo "Listing Antergos mirrors by speed..."
		sudo mv antergos-mirrorlist antergos-mirrorlist.backup
		sudo sh -c "rankmirrors antergos-mirrorlist.backup > antergos-mirrorlist"
		update_and_upgrade_arch
		
		# Debloat the system
		echo "Removing bloat software..."
		sudo sh -c "pacman -Rns gnome-robots gnome-chess gnome-tetravex gnome-nibbles xnoise empathy anjuta aisleriot accerciser gnome-sudoku gnome-mahjongg  four-in-a-row five-or-more evolution gnome-klotski iagno gnome-mines polari quadrapassel tali swell-foop transmission-cli --noconfirm 2>/dev/null"

		# Install common software
		arch_install_base_gui
		arch_install_aur_base_gui

		# Set up /home
		linux_setup_home

		# Set up git
		linux_setup_git

		# Set up SSH client
		linux_setup_ssh_client

		# Set up ZSH
		linux_setup_zsh

		# Set up vim
		linux_setup_vim

		# Set up conky
		linux_setup_conky

		# Set up GNOME startup programs
		linux_gnome_startup_apps
		;;
	*)
		k_os_settings
		;;
esac

echo "Setup complete!"
exit 0
