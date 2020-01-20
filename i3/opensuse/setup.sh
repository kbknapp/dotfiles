git clone https://github.com/kbknapp/dotfiles .dotfiles

# Update System
sudo zypper dup

# Media
sudo zypper ar -f http://packman.inode.at/suse/openSUSE_Tumbleweed/ packman
sudo zypper ar -f http://opensuse-guide.org/repo/openSUSE_Tumbleweed/ libdvdcss
sudo zypper ref
sudo zypper install -f libxine2-codecs ffmpeg-4  dvdauthor gstreamer-plugins-bad gstreamer-plugins-bad-orig-addon gstreamer-plugins-base  gstreamer-plugins-good gstreamer-plugins-good-extra gstreamer-plugins-libav gstreamer-plugins-ugly gstreamer-plugins-ugly-orig-addon vlc smplayer x264 x265 vlc-codecs vlc-codec-gstreamer ogmtools libavcodec58 gstreamer-plugins-vaapi

# Powerlevel10k
sudo zypper install zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
cp .dotfiles/p10k/.p10k.zsh ~
sudo chsh -s $(which zsh) kevin
git clone https://github.com/robbyrussell/oh-my-zsh .oh-my-zsh
cp .dotfiles/zsh/zshrc-linux-p10k .zshrc
git clone https://github.com/momo-lab/zsh-abbrev-alias

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup default nightly
cp -r .dotfiles/alacritty/ .config/
bash .dotfiles/rust/cargo_install/install_apps 
cp -r i3/fedora/common/home/.local/* ~/.local/
fc-cache -f -v

# Alacritty
mkdir -p .build
cd .build/
git clone https://github.com/jwilm/alacritty
sudo zypper install libxcb-devel libxcb-render0 libxcb-shape0 libxcb-xfixes0 libexpat-devel fontconfig-devel
cd .build/alacritty/
cargo build --release
sudo cp target/release/alacritty /usr/bin

# i3-gaps
sudo zypper install i3-gaps
sudo vim /usr/bin/kde-i3.sh
sudo chmod +x /usr/bin/kde-i3.sh
cp i3/fedora/buu/home/.config/i3/config ~/.config/i3/

# Snapd
sudo zypper addrepo --refresh https://download.opensuse.org/repositories/system:/snappy/openSUSE_Tumbleweed snappy
sudo zypper --gpg-auto-import-keys refresh
sudo zypper dup --from snappy
sudo zypper install snapd
sudo systmectl enable snapd
sudo systemctl enable snapd
sudo systemctl start snapd
sudo systemctl enable snapd.apparmor
sudo systemctl start snapd.apparmor

# Snaps
sudo snap install mailspring

cd .build/
git clone https://github.com/meskarune/i3lock-fancy.git
git clone https://github.com/hanschen/ksuperkey
git clone --recursive https://github.com/jaagr/polybar
git clone https://github.com/yshui/compton

# i3lock-fancy
cd ~/.build/i3lock-fancy/
sudo make install

# ksuperkey
cd ~/.build/ksuperkey/
sudo zypper install libX11-devel libXtst-devel
make
sudo make install

# polybar
cd ~/.build/polybar/
./build.sh --all-features -g -f

# compton
cd ~/.build/compton/
git submodule update --init --recursive
sudo zypper install meson libev-devel libXrender-devel xcb-util-devel xcb-util-renderutil-devel
meson --buildtype=release . build
