sudo dnf install git 
git clone https://github.com/kbknapp/dotfiles .dotfiles

mkdir -pv {.build,Projects,.tmp,.local/bin,.bin,bin}

sudo dnf install -y \
	https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
	https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y fedora-workstation-repositories rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted
sudo dnf groupupdate multimedia sound-and-video
sudo dnf config-manager --set-enabled rpmfusion-nonfree-nvidia-driver

sudo dnf install -y @development-tools @virtualization emacs exfat-utils ffmpeg fuse-exfat fuse-sshfs lm_sensors openssh-askpass p7zip p7zip-plugins pv python3-devel unar virt-top virt-manager arc-theme youtube-dl adobe-source-code-pro-fonts gitg meld tig exfat-utils fuse-exfat fuse-sshfs lm_sensors 'mozilla-fira-*' pv gvfs-smb gvfs-fuse gvfs-nfs util-linux-user vlc podman wavemon neovim python3-neovim ansible adobe-source-code-pro-fonts borgbackup iotop nload vim-enhanced zsh zsh-syntax-highlighting cockpit cockpit-bridge libguestfs-tools guestfs-browser ncdu flatpak gcc make fzf llvm clang pkgconfig arandr rofi cmake gcc-c++ automake i3status meson xfsprogs

# nVidia
sudo dnf install xorg-x11-drv-nvidia akmod-nvidia xorg-x11-drv-nvidia-cuda vulkan xorg-x11-drv-nvidia-cuda-libs vdpauinfo libva-vdpau-driver libva-utils

# Libs for i3 etc.
sudo dnf install -y libX11-devel libXtst-devel pulseaudio-libs-devel jsoncpp-devel alsa-lib-devel wireless-tools-devel libmpdclient-devel libcurl-devel cairo-devel xcb-proto xcb-util-devel xcb-util-wm-devel xcb-util-image-devel libxcb-devel xcb-util-keysyms-devel xcb-util-devel xcb-util-wm-devel xcb-util-xrm-devel yajl-devel libXrandr-devel startup-notification-devel libev-devel xcb-util-cursor-devel libXinerama-devel libxkbcommon-devel libxkbcommon-x11-devel pcre-devel pango-devel uthash-devel libX11-devel libXcomposite-devel libXfixes-devel libXdamage-devel libXrender-devel libXext-devel libXrandr-devel libXinerama-devel libconfig-devel pcre-devel libdrm-devel mesa-libGL-devel dbus-devel asciidoc desktop-file-utils uthash-devel libxdg-basedir-develfontconfig-devel freetype-devel

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
rustup default nightly
rustup component add rust-src

cd ~/.build/
for REPO in {https://github.com/jwilm/alacritty,https://github.com/meskarune/i3lock-fancy.git,https://github.com/hanschen/ksuperkey,https://github.com/Airblader/i3,https://github.com/jaagr/polybar,https://github.com/yshui/compton}; do git clone --recursive $REPO; done

cd ~/.build/i3-gaps/ && \
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

cd ~/.build/compton/ && \
	git submodule update --init --recursive && \
	meson --buildtype=release . build && \
	ninja -C build && \
	sudo ninja -C build install

cd
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp -r ~/.dotfiles/nvim/ ~/.config/
nvim +PlugInstall +qall

cd ~/.build/alacritty/
sudo dnf install 
cargo build --release
sudo cp target/release/alacritty /usr/bin

cp -r ~/.dotfiles/alacritty/ ~/.config/

sudo dnf clean all
sudo dnf upgrade --best --allowerasing
sudo dnf upgrade

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

cp ~/.dotfiles/doom-emacs/* ~/.doom.d/
~/.emacs.d/bin/doom sync
~/.emacs.d/bin/doom build
