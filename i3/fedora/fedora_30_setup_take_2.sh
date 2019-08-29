# Dirs
mkdir -pv {.build,Projects,.tmp,.local/bin,.bin,bin}

# remove
sudo dnf remove claws-mail orage xfburn geany pidgin asunder parole pragha abiword gnumeric

sudo dnf install fedora-workstation-repositories adobe-source-code-pro-fonts   gitg meld tig exfat-utils fuse-exfat fuse-sshfs lm_sensors 'mozilla-fira-*'   pv gvfs-smb gvfs-fuse gvfs-nfs fish ncdu git
sudo dnf install util-linux-user

sudo dnf update

git clone https://github.com/kbknapp/dotfiles .dotfiles

# RPM Fusion
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video
sudo dnf install rpmfusion-free-release-tainted
sudo dnf install rpmfusion-nonfree-release-tainted

sudo dnf config-manager --set-enabled google-chrome
sudo dnf config-manager --set-enabled rpmfusion-nonfree-nvidia-driver
sudo dnf config-manager --set-enabled rpmfusion-nonfree-steam

# VLC for Sound and Media Libs
sudo dnf install vlc

# Nvidia
#sudo dnf install xorg-x11-drv-nvidia akmod-nvidia xorg-x11-drv-nvidia-cuda
#sudo dnf install vulkan
#sudo dnf install xorg-x11-drv-nvidia-cuda-libs
#sudo dnf install vdpauinfo libva-vdpau-driver libva-utils

cd ~/.build/
git clone https://github.com/kitsunyan/intel-undervolt

# Undervolt
git clone https://github.com/kitsunyan/intel-undervolt
cd intel-undervolt/
./configure --enable-systemd
make -j4
sudo make install
sudo cp ~/.dotfiles/intel-undervolt/intel-undervolt.conf /etc/
sudo intel-undervolt apply
sudo systemctl start intel-undervolt
sudo systemctl enable intel-undervolt

# Git
git config --global rebase.autosquash true
git config --global color.ui true
git config --global user.email "kbknapp@gmail.com"
git config --globla user.name "Kevin K."
git config --global user.name "Kevin K."
git config --global merge.tool vimdiff
git config --global user.signingkey 17218E4B3692F01A
git config --global commit.gpgsign true


# Podman
sudo dnf install podman

# Flatpak 
sudo dnf install -y flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

cd ~/.build/
sudo dnf install git gcc make libX11-devel libXtst-devel pkgconfig arandr rofi nitrogen pulseaudio-libs-devel cmake @development-tools gcc-c++ i3-ipc jsoncpp-devel alsa-lib-devel wireless-tools-devel libmpdclient-devel libcurl-devel cairo-devel xcb-proto xcb-util-devel xcb-util-wm-devel xcb-util-image-devel libxcb-devel xcb-util-keysyms-devel xcb-util-devel xcb-util-wm-devel xcb-util-xrm-devel yajl-devel libXrandr-devel startup-notification-devel libev-devel xcb-util-cursor-devel libXinerama-devel libxkbcommon-devel libxkbcommon-x11-devel pcre-devel pango-devel gcc automake i3status meson uthash-devel gcc libX11-devel libXcomposite-devel libXfixes-devel libXdamage-devel libXrender-devel libXext-devel libXrandr-devel libXinerama-devel libconfig-devel pcre-devel libdrm-devel mesa-libGL-devel dbus-devel asciidoc desktop-file-utils meson uthash-devel libxdg-basedir-devel cmake fzf

git clone https://github.com/jwilm/alacritty
git clone https://github.com/meskarune/i3lock-fancy.git
git clone https://github.com/hanschen/ksuperkey
git clone --recursive https://github.com/jaagr/polybar
git clone https://github.com/Airblader/i3 i3-gaps
git clone https://github.com/yshui/compton

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env 
rustup default nightly
# clippy doesnt work right now
rustup component add rls rustfmt

# i3-Gaps
cd ~/.build/i3-gaps/
autoreconf --force --install
rm -rf build/
mkdir build
cd build/
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make -j8
sudo make install

# i3lock-fancy
cd ~/.build/i3lock-fancy/
sudo make install

# ksuperkey
cd ~/.build/ksuperkey/
make
sudo make install

# polybar
cd ~/.build/polybar/
./build.sh --all-features -g -f

# Compton
cd ~/.build/compton/
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

# neovim
sudo dnf install neovim python3-neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ls ~/.dotfiles
cp -r nvim/ ~/.config/
nvim +PlugInstall +qall

cd ~/.dotfiles/i3/fedora/common/home
cp -r bin/ ~
cp -r .config/* ~/.config/
cp -r .local/* ~/.local/
cp -r .xprofile ~
cp .Xresources ~

cd ~/.dotfiles/i3/fedora/krillin/home/
ls .config/
cp -r .config/* ~/.config/
cd ~/.dotfiles/i3/fedora/buu/home/
cp -r .config/* ~/.config/

sudo setenforce 0
sudo dnf install fish snapd
sudo snap install lxd

# Fish
sudo cp -r ~/.dotfiles/fish ~/.config/
sudo chsh -s $(which fish) kevin

# alacritty
cd ~/.build/alacritty/
git checkout v0.3.3
cargo build --release
sudo cp target/release/alacritty /usr/bin
cp -r ~/.dotfiles/alacritty/ ~/.config/

# fonts
fc-cache -f -v
