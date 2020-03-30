
git clone https://github.com/kbknapp/dotfiles .dotfiles

mkdir -pv {.build,Projects,.tmp,.local/bin,.bin,bin}


# Media
sudo zypper ar -cfp 89 http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman
sudo zypper ar -f http://packman.inode.at/suse/openSUSE_Tumbleweed/ packman
sudo zypper ar -f http://opensuse-guide.org/repo/openSUSE_Tumbleweed/ libdvdcss
sudo zypper ref
sudo zypper install --allow-vendor-change -f libxine2-codecs ffmpeg-4  dvdauthor gstreamer-plugins-bad \
  gstreamer-plugins-bad-orig-addon gstreamer-plugins-base  gstreamer-plugins-good \
  gstreamer-plugins-good-extra gstreamer-plugins-libav gstreamer-plugins-ugly \
  gstreamer-plugins-ugly-orig-addon vlc smplayer x264 x265 vlc-codecs \
  vlc-codec-gstreamer ogmtools libavcodec58 gstreamer-plugins-vaapi

sudo zypper dup --from packman --allow-vendor-change

# Nvidia
sudo zypper addrepo --refresh https://download.nvidia.com/opensuse/tumbleweed NVIDIA
sudo zypper install x11-video-nvidiaG05

sudo zypper install emacs exfat-utils ffmpeg fuse-exfat p7zip pv python3-devel \
  unar gitg meld tig exfat-utils fuse-exfat wavemon neovim python3-neovim iotop \
  nload vim-enhanced ncdu flatpak fzf llvm clang pkgconfig rofi i3status meson \
  xfsprogs feh cmake

sudo zypper install libX11-devel libXtst-devel jsoncpp-devel libmpdclient-devel \
  libcurl-devel cairo-devel  xcb-util-devel xcb-util-wm-devel xcb-util-image-devel \
  libxcb-devel xcb-util-keysyms-devel xcb-util-devel xcb-util-wm-devel \
  xcb-util-xrm-devel libXrandr-devel startup-notification-devel libev-devel \
  xcb-util-cursor-devel libXinerama-devel libxkbcommon-devel libxkbcommon-x11-devel \
  pcre-devel pango-devel uthash-devel libX11-devel libXcomposite-devel \
  libXfixes-devel libXdamage-devel libXrender-devel libXext-devel libXrandr-devel \
  libXinerama-devel libconfig-devel pcre-devel libdrm-devel Mesa-libGL-devel  \
  desktop-file-utils uthash-devel libxdg-basedir-devel fontconfig-devel \
  freetype-devel libyajl-devel dbus-1-devel

# No target:
# pulseaudio-libs-devel wireless-tools-devel xcb-proto lm_sensors
# alsa-lib-devel

# Contains about 2,500 texlive deps
# sudo zypper install asciidoc

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
rustup default nightly
rustup component add rust-src

cd ~/.build/
for REPO in {https://github.com/jwilm/alacritty,https://github.com/meskarune/i3lock-fancy.git,https://github.com/hanschen/ksuperkey,https://github.com/Airblader/i3,https://github.com/jaagr/polybar,https://github.com/yshui/picom}; do git clone --recursive $REPO; done

cd ~/.build/i3/ && \
        autoreconf --force --install && \
        mkdir -p build \
        && \
        cd build/ \
        && \
        ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers && \
        make -j16 && \
        sudo make install

cd ~/.build/ksuperkey/ && \
        make && \
        sudo make install

cd ~/.build/polybar/ && \
        ./build.sh --all-features -g -f

cd ~/.build/picom/ && \
        git submodule update --init --recursive && \
        meson --buildtype=release . build && \
        ninja -C build && \
        sudo ninja -C build install

cd
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp -r ~/.dotfiles/nvim/ ~/.config/
nvim +PlugInstall +qall

cd ~/.build/alacritty/ && \
        cargo build --release && \
        sudo cp target/release/alacritty /usr/bin

cp -r ~/.dotfiles/alacritty/ ~/.config/

sudo zypper dup

git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

cp ~/.dotfiles/doom-emacs/* ~/.doom.d/
~/.emacs.d/bin/doom sync
~/.emacs.d/bin/doom build

cd ~/.config
git clone https://github.com/momo-lab/zsh-abbrev-alias



# Powerlevel10k
sudo zypper install zsh
git clone https://github.com/robbyrussell/oh-my-zsh .oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${HOME}/.oh-my-zsh/themes/powerlevel10k
cp .dotfiles/p10k/.p10k.zsh ${HOME}
sudo chsh -s $(which zsh) kevin
cp ${HOME}/.dotfiles/zsh/zshrc-linux-p10k .zshrc
git clone https://github.com/momo-lab/zsh-abbrev-alias ${HOME}/.config/


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
sudo snap install mailspring lxd
sudo usermod -aG lxd kevin
sudo snap install clion --classic

sudo cp ~/.dotfiles/i3/opensuse/etc/* /etc/

bash ${HOME}/.dotfiles/flathub/install_apps

# Intel-undervolt
cd .build/
git clone https://github.com/kitsunyan/intel-undervolt
cd intel-undervolt/
./configure --enable-systemd && make && sudo make install
sudo cp ${HOME}/.dotfiles/intel-undervolt/intel-undervolt.conf /etc/
sudo systemctl enable intel-undervolt

cp .dotfiles/i3/common/home/.xprofile .
cp .dotfiles/i3/common/home/.Xresources .

cp -r common/home/.local/* ~/.local/
cp -r common/home/.config/* ~/.config/
sudo cp common/usr/bin/rofi_run /usr/bin
cp -r opensuse/home/.config/* ~/.config/
sudo cp -r opensuse/usr/bin/i3-kde.sh /usr/bin

# Common apps
sudo zypper install transmission-qt
sudo zypper install docker docker-compose
sudo usermod -aG docker kevin


sudo zypper install openssl-devel
bash .dotfiles/rust/cargo_install/install_apps 

# Set Hostname
sudo hostnamectl set-hostname buu
