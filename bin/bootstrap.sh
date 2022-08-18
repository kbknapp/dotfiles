mv ~/dotfiles ~/.dotfiles

# neovim
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
