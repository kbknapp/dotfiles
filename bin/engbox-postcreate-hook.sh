#!/usr/bin/env bash

set -euo pipefail

sudo apt install -y  linux-tools-$(uname -r) python3-poetry python3-pip \
  python3-cachecontrol llvm clang libxcb1-dev libxcb-shape0-dev \
  libxcb-xfixes0-dev lldb lld linux-tools-common linux-tools-generic curl \
  pkg-config build-essential protobuf-compiler direnv

# Python
pip3 install --user --upgrade black

# Repos
cd
git clone git@github.com:kbknapp/baseline
mkdir -p ~/Projects
cd ~/Projects/
git clone git@github.com:seaplane-io/eng
git sparse-checkout init --cone
git checkout main
git sparse-checkout set seaplanet/ planet/spaceplane/ scripts/safecracker/
ln -s ~/Projects/eng ~/eng
git clone git@github.com:seaplane-io/seaplane
git clone git@github.com:seaplane-io/just
git clone git@github.com:seaplane-io/documentation
git clone git@github.com:seaplane-io/nomad-driver-seaplane
git clone git@github.com:seaplane-io/temp-nomad-driver
cd

# Neovim
wget https://github.com/neovim/neovim/releases/download/v0.8.1/nvim-linux64.tar.gz
tar xzf nvim-linux64.tar.gz
sudo cp -r nvim-linux64/* /usr/local/
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.config
cp -r ~/.dotfiles/nvim ~/.config
nvim +PlugInstall +qall

# ZSH
git clone https://github.com/momo-lab/zsh-abbrev-alias ~/.config/zsh-abbrev-alias/ || true
git clone https://github.com/robbyrussell/oh-my-zsh ~/.oh-my-zsh || true
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting || true

rm ~/.zshrc || true
ln -s ~/.dotfiles/zsh/zshrc-linux-engbox ~/.zshrc

# Emacs
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt update
sudo apt install -y emacs28-nox
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
~/.emacs.d/bin/doom install
cp ~/.dotfiles/doom-emacs/* ~/.doom.d/
~/.emacs.d/bin/doom sync
~/.emacs.d/bin/doom build

# Starship
cp ~/.dotfiles/starship/starship.toml.container ~/.config/starship.toml

# tmux
cp ~/.dotfiles/tmux/.tmux.conf ~/

# npm
mkdir -p ~/.local/npm-global
npm config set prefix ~/.local/npm-global
npm install -g @withgraphite/graphite-cli@latest
npm install -g @stoplight/spectral-cli
npm install -g markdownlint-cli

# git
cp ~/.dotfiles/git/.gitignore ~/
cat <<EOF > ~/.dotfiles/git/.gitconfig
[user]
	email = kevin@seaplane.io
	name = kbknapp
[color]
        ui = true
[rebase]
        autosquash = true
[pull]
        rebase = true
[core]
        excludesfile = ~/.gitignore
[gpg]
        format = ssh
[commit]
	gpgsign = true
[tag]
	gpgsign = true
EOF
cat ~/.dotfiles/git/.gitconfig.delta >> ~/.gitconfig
git config --global user.signingkey "$(ssh-add -L)"

# SSH
cp ~/.dotfiles/ssh/rc ~/.ssh/
chmod +x ~/.ssh/rc

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install \
  bindgen exa fd-find ripgrep cargo-deny cargo-lichking bpf-linker \
  cargo-generate cargo-update hexyl jless topgrade zellij zoxide

cargo install --locked git-branchless
