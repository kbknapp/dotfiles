#!/bin/bash
VERSION="0.1.2"
# Setup pacman mirrors
echo "############################"
echo "## Kustom Baseline v$VERSION"
echo "############################"
echo
echo "Enabling multilib repo"
sudo sh -c "echo \"[multilib]\" >> /etc/pacman.conf"
sudo sh -c "echo \"Include = /etc/pacman.d/mirrorlist\" >> /etc/pacman.conf"
cd /etc/pacman.d
echo "Downloading the latest US mirrors"
sudo mv mirrorlist mirrorlist.backup
sudo curl -LSso mirrorlist.tmp https://www.archlinux.org/mirrorlist/\?country\=US
sudo sh -c "sed -e \"s/^#Server/Server/g\" mirrorlist.tmp > mirrorlist-us"
echo "Listing Arch mirrors by speed"
sudo sh -c "rankmirrors -n 6 mirrorlist-us > mirrorlist"
sudo rm mirrorlist.tmp
sudo mv antergos-mirrorlist antergos-mirrorlist.backup
echo "Listing Antergos mirrors by speed"
sudo sh -c "rankmirrors -n 6 antergos-mirrorlist.backup > antergos-mirrorlist"
echo "Updating local mirror repo"
sudo pacman -Syy
echo "Peforming system update"
sudo pacman -Syu --noconfirm

# Debloat the system
echo "Removing bloat software"
sudo pacman -Rns gnome-robots gnome-chess gnome-tetravex gnome-nibbles xnoise empathy anjuta aisleriot accerciser gnome-sudoku gnome-mahjongg  four-in-a-row five-or-more evolution gnome-klotski iagno gnome-mines polari quadrapassel tali swell-foop transmission-cli --noconfirm

# Install common software
echo "Installing required software"
sudo pacman -S go tree vim mercurial zsh firefox guake ncdu terminator emacs --noconfirm

# Setup home dir
cd ~
echo "Creating required home directories"
mkdir Projects

# git configurations
echo "Configuring git"
git config --global user.name "Kevin K."
git config --global user.email "kbknapp@gmail.com"
git config --global color.ui true

# Clone my repos
echo "Checking for dotfiles"
if [[ ! -d ~/.dotfiles ]]; then
	echo "Cloning dotfiles repo"
	git clone https://github.com/kbknapp/dotfiles .dotfiles
fi
echo "Checking for oh-my-zsh repo"
if [[ ! -d ~/.oh-my-zsh ]]; then
	echo "Cloning oh-my-zsh repo"
	git clone https://github.com/kbknapp/oh-my-zsh .oh-my-zsh
fi

# Setup ZSH
echo "Setting up ZSH"
cp .oh-my-zsh/templates/zshrc-linux.zsh-template .zshrc
sudo cd /root
sudo git clone https://github.com/kbknapp/oh-my-zsh /root/.oh-my-zsh
sudo cp /root/.oh-my-zsh/templates/zshrc-linux.zsh-template /root/.zshrc
sudo chsh -s /bin/zsh ${whoami}
cd ~
chsh -s /bin/zsh ${whoami}

# Setup GNOME Startup Apps (guake specifically)
cd ~
echo "Configuring GNOME startup applications"
mkdir -p .config/autostart
cd .config/autostart
cp ~/.dotfiles/gauke/guake.desktop ~/.config/autostart
cp ~/.dotfiles/conky/conky.desktop ~/.config/autostart

# Setup conky
cd ~
cp ~/.dotfiles/conky/conkyrc ~/.conkyrc

# Setting up Go
cd ~
mkdir -p .go/{bin,src/github.com,pkg}
export GOPATH=$HOME/.go
# Used for stale packages in Go 1.3.1
sudo go install std
go get code.google.com/p/go.tools/cmd/goimports

# Setting up Rust
cd ~
mkdir -p Projects/rust-nightlies
mkdir -p .rust/{bin,pkg,src/github.com}
cd ~/Projects/rust-nightlies
curl -LSso rustup.sh https://static.rust-lang.org/rustup.sh
chmod +x rustup.sh
sudo ./rustup.sh

# AUR Insalls (Maybe)
#yaourt -S pycharm-community
#yaourt -S sublime-text-dev
#yaourt -S haroopad
#yaourt -S conky-nvidia

echo "Complete!"
