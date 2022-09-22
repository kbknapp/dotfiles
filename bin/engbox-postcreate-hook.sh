#!/usr/bin/env bash

set -euo pipefail

DEFAULT_AMD_REMOTE=engbox-amd64-us1
DEFAULT_ARM_REMOTE=engbox-amd64-us1

mv ~/dotfiles ~/.dotfiles
mkdir -p ${HOME}/Projects
mv ${HOME}/eng ${HOME}/Projects/
ln -s ${HOME}/Projects/eng ${HOME}/eng
mv ${HOME}/seaplane ${HOME}/Projects/

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

sudo apt install -y  linux-tools-$(uname -r)

# Retstore in flight projects
if [[ "$(uname -m)" == "aarch64" ]]; then
  REMOTE=${DEFAULT_AMD_REMOTE}
else
  REMOTE=${DEFAULT_ARM_REMOTE}
fi

if lxc list -f csv ${REMOTE}: | grep -q $(hostname)-xfer ; then
  lxc file pull -r ${REMOTE}:$(hostname)-xfer/opt/projects.tgz ${HOME}/ || exit 1
  lxc delete ${REMOTE}:$(hostname)-xfer --force
  tar xzf ${HOME}/projects.tgz -C ${HOME}/Projects
fi
