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

sudo zypper dup

# Powerlevel10k
sudo zypper install zsh

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

cp .dotfiles/i3/common/home/.xprofile .
cp .dotfiles/i3/common/home/.Xresources .

cp -r common/home/.local/* ~/.local/
cp -r common/home/.config/* ~/.config/
sudo cp common/usr/bin/rofi_run /usr/bin
cp -r opensuse/home/.config/* ~/.config/
sudo cp -r opensuse/usr/bin/i3-kde.sh /usr/bin

# Common apps
sudo zypper install transmission-qt
sudo zypper install openssl-devel
