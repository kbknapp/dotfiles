# Use an active fork of Compton
sudo apt install libev-libevent-dev libdbus-1-dev libgl1-mesa-dev \
  libxcb-present-dev libxcb-sync-dev libxcb-damage0-dev \
  libx11-xcb-dev libev-dev uthash-dev libxdg-basedir-dev \
  libconfig-dev libxcb-render-util0-dev libxcb-composite0-dev \
  libxcb-image0-dev libxcb-xinerama0-dev libpixman-1-dev \
  libpcre3-dev meson

cd "${BUILD_DIR}"
git clone https://github.com/yshui/compton
cd compton/
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

# i3-gaps
# Install Deps and Software
sudo apt install -y \
    arandr \
    rofi \
    nitrogen \
    i3status i3lock i3lock-fancy autoconf pkg-config \
    libstartup-notification0-dev libxcb-xkb-dev libxcb-util-dev \
    libxcb-cursor-dev libxcb-keysyms1-dev libxcb-icccm4-dev \
    libxcb-xrm-dev libxkbcommon-x11-dev libxkbcommon-dev \
    libyajl-dev libcairo2-dev libpango1.0-dev

mkdir -pv "${BUILD_DIR}"
git clone https://github.com/Airblader/i3 "${BUILD_DIR}"/i3-gaps
cd "${BUILD_DIR}"/i3-gaps/
autoreconf --force --install
rm -rf build
mkdir -pv build
cd build/
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make -j"${NPROC}"
sudo make install

# Polybar
sudo apt install -y \
	libasound2-dev libcurl4-openssl-dev libmpdclient-dev \
	libiw-dev libpulse-dev xcb-proto xcb libxcb-ewmh-dev \
	python-xcbgen libcairo2-dev libxcb-composite0-dev \
  libxcb-randr0-dev libxcb-image0-dev libxcb-icccm4-dev \
  libxcb-util0-dev

git clone https://github.com/jaagr/polybar "${BUILD_DIR}"/polybar
cd "${BUILD_DIR}"/polybar/
./build.sh -f -g --all-features

# KSuperkey
git clone https://github.com/hanschen/ksuperkey.git "${BUILD_DIR}"/ksuperkey
cd "${BUILD_DIR}"/ksuperkey
make
sudo make install

