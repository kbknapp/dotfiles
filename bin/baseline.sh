#!/bin/bash
VERSION="0.2.2"

# Helper Functions
function k_os_settings() {
	echo "Must set K_OS before running, values include:"
	echo "    ANTERGOS"
	# echo "    OSX"
	# echo "    UBUNTU"
	echo "Exiting..."
	exit 1
}

# Check that variables set correctly
K_OS="ANTERGOS"
LUSER="kevin"

function antergos_mirror_list(){
	ODIR="$(pwd)"
	cd /etc/pacman.d
	mv antergos-mirrorlist antergos-mirrorlist.backup
	echo -n "Listing Antergos mirrors by speed..."
	rankmirrors antergos-mirrorlist.backup > antergos-mirrorlist
	echo "done"
	cd "${ODIR}"
}

function pacman_mirror_list() {
	ODIR="$(pwd)"
	echo -n "Downloading the latest Arch US mirrors..."
	cd /etc/pacman.d
	mv mirrorlist mirrorlist.backup
	curl -Ls https://www.archlinux.org/mirrorlist/\?country\=US | sed -e 's/^#Server/Server/g' > mirrorlist-us
	echo "done"
	echo -n "Listing Arch mirrors by speed..."
	rankmirrors mirrorlist-us > mirrorlist
	echo "done"
	cd "${ODIR}"
}

function arch_update_and_upgrade(){
	echo "Updating local mirror repos..."
	pacman -Syy
	echo "Peforming system upgrade..."
	pacman -Syu --noconfirm
}

function arch_install_base(){
	echo "Installing base terminal applications..."
	pacman -S zsh git vim --noconfirm
}

function arch_install_base_gui(){
	arch_install_base
	echo "Installing base GUI software..."
	pacman -S firefox guake vlc terminator --noconfirm
}

function arch_install_aur_base(){
	# Install aura
	ODIR="$(pwd)"
	cd ~
	mkdir -p Builds
	cd Builds
	echo -n "Downloading aura-bin from the AUR..."
	curl -Lso aura-bin.tar.gz https://aur.archlinux.org/packages/au/aura-bin/aura-bin.tar.gz
	echo "done"
	tar xf aura-bin.tar.gz
	cd aura-bin
	echo "Running makepkg for aura..."
	#makepkg -sci
	echo -n "Cleaning up..."
	cd ..
	#rm -r aura-bin
	echo "done"
	cd "${ODIR}"
}

function arch_install_aur_base_gui(){
	arch_install_aur_base
	 #arua -A sublime-text-dev haroopad conky-lua-nv google-chrome byobu
}

function linux_setup_home(){
	# Set up user home
	ODIR="$(pwd)"
	cd ~
	echo -n "Creating required home directories for $USER..."
	mkdir -p {.tmp,.bin,Projects}
	echo "done"
	echo -n "Checking for dotfiles repo..."
	if [[ ! -d ~/.dotfiles ]]; then
		echo "not found"
		echo "Cloning dotfiles repo..."
		git clone https://github.com/kbknapp/dotfiles .dotfiles
	else
		echo "found"
	fi
	cd "${ODIR}"
}

function linux_setup_git(){
	echo -n "Configuring git..."
	git config --global user.name "Kevin K."
	git config --global user.email "kbknapp@gmail.com"
	git config --global color.ui true
	echo "done"
}

function linux_setup_ssh_client(){
	echo "Configuring SSH..."
	ssh-keygen -t rsa -C "kbknapp@gmail.com"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa
}

function linux_setup_zsh(){
	ODIR="$(pwd)"
	cd ~
	echo -n "Checking for oh-my-zsh..."
	if [[ ! -d  ~/.oh-my-zsh ]]; then
		echo "not found"
		echo "Cloning oh-my-zsh repo"
		git clone https://github.com/robbyrussell/oh-my-zsh .oh-my-zsh
	else
		echo "found"
	fi
	echo -n "Copying zsh profiles..."
	cp .dotfiles/zsh/zshrc-linux .zshrc
	cp .dotfiles/zsh/kustom-linux.zsh-theme .oh-my-zsh/themes
	cat .dotfiles/zsh/addons/git.zshrc-addon >> .zshrc
	chsh -s "$(which zsh)" "$USER"
	echo "done"
	cd "${ODIR}"
}

function linux_gnome_startup_apps(){
	ODIR="$(pwd)"
	cd ~
	echo "Configuring GNOME startup applications..."
	echo -n "Checking for ~/.config/autostart..."
	if [[ ! -d .config/autostart ]]; then
		echo "not found"
		mkdir -p .config/autostart
	else
		echo "found"
	fi
	cd .config/autostart
	echo -n "Adding guake to autostart..."
	cp ~/.dotfiles/gauke/guake.desktop ~/.config/autostart
	echo "done"
	echo -n "Adding ConkyBar to autostart..."
	cp ~/.dotfiles/conky/conkybar.desktop ~/.config/autostart
	echo "done"
	cd "${ODIR}"
}

function linux_setup_vim(){
	# Setting up vim for user
	ODIR="$(pwd)"
	cd ~ 
	echo "Setting up vim for $USER..."
	ln -s .dotfiles/vim .vim
	ln -s .vim/vimrc-linux .vimrc
	cd .vim/bundle
	git clone https://github.com/gmarik/Vundle.vim
	vim +PluginInstall +qall
	cd "${ODIR}"
}

function linux_setup_conky(){
	ODIR="$(pwd)"
	echo "Cloning ConkyBar..."
	cd ~/.config
	git clone https://github.com/kbknapp/conkybar.git conky
	cd "${ODIR}"
}

function linux_setup_byobu(){
	ODIR="$(pwd)"
	echo -n "Copying byobu keybindings files..."
	cp /home/$1/.dotfiles/byobu/* /usr/share/byobu/keybindings
	echo "done"
	cd "${ODIR}"
}

# Setting up Go
# cd ~
# mkdir -p .go/{bin,src/github.com,pkg}
# export GOPATH=$HOME/.go
# Used for stale packages in Go 1.3.1
#  go install std
# go get code.google.com/p/go.tools/cmd/goimports

# Setting up Rust
# cd ~
# mkdir -p Projects/rust-nightlies
# mkdir -p .rust/{bin,pkg,src/github.com}
# cd ~/Projects/rust-nightlies
# curl -LSso rustup.sh https://static.rust-lang.org/rustup.sh
# chmod +x rustup.sh
#  ./rustup.sh

echo "############################"
echo "## Kustom Baseline v$VERSION"
echo "############################"
echo

case "$K_OS" in
	ANTERGOS)
		echo "OS set to ${K_OS}..."
		
		# Set up mirror lists
		echo -n "Enabling [multilib] repos..."
		sh -c "echo \"[multilib]\" >> /etc/pacman.conf"
		sh -c "echo \"Include = /etc/pacman.d/mirrorlist\" >> /etc/pacman.conf"
		echo "done"

		pacman_mirror_list
		antergos_mirror_list	
		
		# Debloat the system
		echo -n "Removing bloat software..."
		sh -c "pacman -Rns gnome-robots gnome-chess gnome-tetravex gnome-nibbles xnoise empathy anjuta aisleriot accerciser gnome-ku gnome-mahjongg  four-in-a-row five-or-more evolution gnome-klotski iagno gnome-mines polari quadrapassel tali swell-foop transmission-cli --noconfirm 2>/dev/null"
		echo "done"

		# Install common software
		arch_install_base_gui
		arch_install_aur_base_gui

		# Set up /home
		linux_setup_home
		linux_setup_home

		# Set up git
		linux_setup_git

		# Set up SSH client
		linux_setup_ssh_client

		# Set up ZSH
		linux_setup_zsh
		linux_setup_zsh

		# Set up vim
		linux_setup_vim
		linux_setup_vim

		# Set up conky
		linux_setup_conky

		# Set up GNOME startup programs
		linux_gnome_startup_apps

		# Set byobu keybindings
		LOCAL_USER=$USER
		linux_setup_byobu "$LOCAL_USER"
		;;
	*)
		k_os_settings
		;;
esac

echo "Setup complete!"
exit 0
