#!/bin/bash

set -e

NAME=baseline
VER="0.1"

_I3=0
_STEAM=0
_FISH=0
_DEFAULT_FISH=0
_ZSH=0
_DEFAULT_ZSH=0
_NEOVIM=0
_VIM=0
_RUST=0
_ALACRITTY=0
_B_ALACRITTY=0


for arg in "$@"; do
    case $arg in
        -h|--help)
            print_help
            exit 0
            ;;
        -v|--version)
            echo -e "$NAME -- v$VER"
            exit 0
            ;;
        --vim)
	    _VIM=1
            ;;
        --neovim)
	    _NEOVIM=1
            ;;
        --steam)
	    _STEAM=1
            ;;
        --steam)
	    _STEAM=1
            ;;
        --fish)
	    _FISH=1
            ;;
        --zsh)
	    _ZSH=1
            ;;
        --fish-default)
	    _FISH_DEFAULT=1
            ;;
        --zsh-default)
	    _ZSH_DEFAULT=1
            ;;
        --i3)
	    _I3=1
            ;;
        --rust)
	    _RUST=1
            ;;
        --build-alacritty)
	    _RUST=1
	    _B_ALACRITTY=1
	    _ALACRITTY=1
            ;;
        -a|--all)
		_I3=1
		_STEAM=1
		_FISH=1
		_ZSH=1
		_NEOVIM=1
		_VIM=1
		_RUST=1
		_ALACRITTY=1
            ;;
        *)
            printf "\nOption does not exist: %s\n\n" "$arg"
            exit 2
	    ;;
    esac
done

mkdir -pv "${HOME}/.bin"
mkdir -pv "${HOME}/bin"
mkdir -pv "${HOME}/.local/bin"
mkdir -pv "${HOME}/.build"
mkdir -pv "${HOME}/.tmp"
mkdir -pv "${HOME}/Projects"

# Install Deps and Software
sudo apt install -y \
    fonts-font-awesome fonts-firacode \
    curl \
    zsh \
    git \
    python-pip \
    vlc \
    git \
    flatpak \
    snapd \
    dconf-cli \
    fzf \
    shellcheck \
    ranger \
    build-essential gcc make pkg-config cmake automake libssl-dev

# clone dotifles if they don't exist yet
if [ ! -d "${HOME}/.dotfiles" ]; then
    git clone https://github.com/kbknapp/dotfiles .dotfiles
fi

# vim handling
if [ $_VIM == 1 ]; then
	sudo apt install -y vim-gtk exuberant-ctags
	cp "${HOME}/.dotfiles/vim/vimrc-linux" "${HOME}/.vimrc"
	mkdir -p "${HOME}/.vim/bundle"
	git clone https://github.com/VundleVim/Vundle.vim "${HOME}/.vim/bundle"
	vim +PluginInstall +qall
fi
if [ $_NEOVIM == 1 ]; then
	sudo apt install -y neovim exuberant-ctags
	cp -r "${HOME}/.dotfiles/nvim/" "${HOME}/.config/"
	curl -fLo "${HOME}/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim +PlugInstall +qall

fi

# Shell Handling
if [ $_ZSH == 1 ]; then
    sudo apt install -y zsh
    git clone https://github.com/robbyrussell/oh-my-zsh "${HOME}/.oh-my-zsh"
    if [ $_ZSH_DEFAULT == 1]; then
	# change the default shell
	sudo chsh -s "$(command -v zsh)" kevin
    fi
fi
if [ $_FISH == 1 ]; then
    sudo apt install -y fish
    if [ $_FISH_DEFAULT == 1]; then
	# change the default shell
	sudo chsh -s "$(command -v fish)" kevin
    fi
fi


if [ $_RUST == 1 ]; then
	# Install Rust
	if [ ! -d "${HOME}/.cargo" ]; then
	    curl https://sh.rustup.rs -sSf | sh
	fi

	# Set default Rust toolchain
	# shellcheck source=../../.cargo/env
	source "${HOME}/.cargo/env"
	rustup default nightly

	# Rust Apps
	bash "${HOME}/.dotfiles/rust/cargo_install/install_apps" || true

	if [ $_B_ALACRITTY == 1 ]; then
		cd "${BUILD_DIR}"
		git clone https://github.com/jwilm/alacritty
		cd alacritty
		cargo build --release
		cp target/release/alacritty "${HOME}/.local/bin"
	fi
fi

pip install --user rtv

# Load Tilix settings
dconf load /com/gexperts/Tilix/ < "${HOME}/.dotfiles/tilix/tilix.dconf"

# Flatpaks
bash "${HOME}/.dotfiles/flathub/install_flathub"
bash "${HOME}/.dotfiles/flathub/install_apps"

# Snaps
sudo snap install lxd
sudo snap install freemind
sudo snap install clion --classic

if [ $_STEAM == 1 ]; then
	echo "currently --steam doesn't do anything"
fi
if [ $_I3 == 1 ]; then
	echo "currently --i3 doesn't do anything"
fi

# Remove software we don't care about
sudo apt remove -y thunderbird fonts-noto-cjk yelp-xsl yelp gnome-mines gnome-sudoku 
sudo apt autoremove -y

sudo apt update
sudo apt upgrade -y
