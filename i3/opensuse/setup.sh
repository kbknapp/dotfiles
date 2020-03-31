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
sudo zypper install docker docker-compose
sudo usermod -aG docker kevin


sudo zypper install openssl-devel
bash .dotfiles/rust/cargo_install/install_apps 
