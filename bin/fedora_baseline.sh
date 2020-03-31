###
# Force update the whole system to the latest and greatest
###

sudo dnf upgrade --best --allowerasing --refresh -y
# And also remove any packages without a source backing them
# If you come from the Fedora 30 Future i'll check if this is still optimal before F30 comes out.
sudo dnf distro-sync -y

###
# Install base packages and applications
###

sudo dnf install \
-y \
darktable `#Easy RAW Editor` \
exfat-utils `#Allows managing exfat (android sd cards and co)` \
ffmpeg `#Adds Codec Support to Firefox, and in general` \
fuse-exfat `#Allows mounting exfat` \
fuse-sshfs `#Allows mounting servers via sshfs` \
git `#VCS done right` \
keepassxc  `#Password Manager` \
lm_sensors `#Show your systems Temparature` \
'mozilla-fira-*' `#A nice font family` \
openssh-askpass `#Base Lib to let applications request ssh pass via gui` \
p7zip `#Archives` \
p7zip-plugins `#Even more of them` \
pv `#pipe viewer - see what happens between the | with output | pv | receiver ` \
python3-devel `#Python Development Gear` \
tilix `#The best terminal manager i know of` \
tuned `#Tuned can optimize your performance according to metrics. tuned-adm profile powersave can help you on laptops, alot` \
unar `#free rar decompression` \
vagrant `#Virtual Machine management and autodeployment` \
vagrant-libvirt `#integration with libvirt` \
virt-manager `#A gui to manage virtual machines` \
mpv `#The best media player (with simple gui)` \
nautilus-extensions `#What it says on the tin` \
nautilus-image-converter \
nautilus-search-tool \
NetworkManager-openvpn-gnome `#To enforce that its possible to import .ovpn files in the settings` \
arc-theme `#A more comfortable GTK/Gnome-Shell Theme` \
pop-icon-theme `#The Icon theme from system76, which is quite nice` \
file-roller-nautilus `#More Archives supported in nautilus` \
gnome-tweak-tool `#Your central place to make gnome like you want` \
gvfs-fuse `#gnome<>fuse` \
gvfs-mtp `#gnome<>android` \
gvfs-nfs `#gnome<>ntfs` \
gvfs-smb `#gnome<>samba` \
tilix-nautilus `#Adds right click open in tilix to nautilus` \
youtube-dl `#Allows you to download and save youtube videos but also to open their links by dragging them into mpv!`

##
# Packages I don't need or want at the moment
##
#libreoffice-gallery-vrt-network-equipment `#Network Icon Preset for LibreOffice` \
#krita  `#Painting done right keep in mind mypaint and gimp cant work together in current upstream versions - yet` \
#mumble `#Talk with your friends` \
#openshot `#Simple Video Editor` \
#python3-neovim `#Python Neovim Libs` \
#rawtherapee `#Professional RAW Editor` \
#spamassassin `#Dep to make sure it is locally installed for Evolution` \
#telegram-desktop `#Chatting, with newer openssl and qt base!` \
#transmission `#Torrent Client` \
#wavemon `#a cli wifi status tool` \
#blender `#3D Software Powerhouse` \
#breeze-cursor-theme `#A more comfortable Cursor Theme from KDE` \
#calibre `#Ebook management` \
#chrome-gnome-shell `#Gnome <> Browser Integration for the gnome plugins website` \
#chromium-vaapi `#Comes with hardware acceleration and all Codecs` \
#evolution-spamassassin `#Helps you deal with spam in Evolution` \
#filezilla `#S/FTP Access` \
#GREYCstoration-gimp \
#gtkhash-nautilus `#To get a file has via gui` \
#htop `#Cli process monitor` \
#inkscape  `#Working with .svg files` \
#kdenlive  `#Advanced Video Editor` \

###
# Developer Niceties
###

sudo dnf install \
-y \
ansible `#Awesome to manage multiple machines or define states for systems` \
adobe-source-code-pro-fonts `#The most beautiful monospace font around` \
borgbackup `#If you need backups, this is your tool for it` \
gitg `#a gui for git, a little slow on larger repos sadly` \
iotop  `#disk usage cli monitor` \
meld `#Quick Diff Tool` \
nethogs `#Whats using all your traffic? Now you know!` \
nload `#Network Load Monitor` \
tig `#cli git tool` \
vim-enhanced `#full vim` \
zsh `#Best shell` \
zsh-syntax-highlighting `#Now with syntax highlighting`

##
# Packages I don't need or want at the moment
##
#nano `#Because pressing i is too hard sometimes` \
#neovim `#the better vim` \

###
# Remove some un-needed stuff
###

sudo dnf remove \
-y \
gnome-shell-extension-background-logo `#Tasteful but nah` \
totem `#With mpv installed totem became a little useless` \
chromium `#Using Chromium resets chromium-vaapi so remove it if installed, userprofiles will be kept and can be used in -vaapi` \
flowblade `#Sadly has really outdated mlt dependencies`


###
# Enable some of the goodies, but not all
# Its the users responsibility to choose and enable zsh, with oh-my-zsh for example
# or set a more specific tuned profile
###

sudo systemctl enable --now tuned
sudo tuned-adm profile balanced

#Performance:
sudo tuned-adm profile desktop

#Virtual Machine Host:
#sudo tuned-adm profile virtual-host

#Virtual Machine Guest:
#sudo tuned-adm profile virtual-guest

#Battery Saving:
#sudo tuned-adm profile powersave

# Virtual Machines
sudo systemctl enable --now libvirtd

# Management of local/remote system(s) - available via http://localhost:9090
sudo systemctl enable --now cockpit.socket

# Steam games (32bit) have issues with the too new 32bit compat libs in fedora
# Flatpak is the better option here
if [ ! -z "$FLATSTEAM" ]; then
	flatpak -y install flathub com.valvesoftware.Steam
	# Installed but not displayed? Check with: flatpak run com.valvesoftware.Steam
fi

if [ ! -z "$FLATSTEAM" ]; then
	sudo dnf install -y steam
fi


###
# These will be more used in the future by some maintainers
# Reenabling them just to make sure.
###

sudo sed -i '0,/enabled=0/s/enabled=0/enabled=1/g' /etc/yum.repos.d/fedora-updates-modular.repo
sudo sed -i '0,/enabled=0/s/enabled=0/enabled=1/g' /etc/yum.repos.d/fedora-modular.repo

#The user needs to reboot to apply all changes.
echo "Please Reboot" && exit 0

###
## WIP
###

sudo dnf remove xfburn-0.5.5-4.fc30.x86_64 geany-libgeany-1.34.1-3.fc30.x86_64 geany-1.34.1-3.fc30.x86_64 claws-mail-plugins-tnef-3.17.3-4.fc30.x86_64 claws-mail-plugins-att-remover-3.17.3-4.fc30.x86_64 claws-mail-plugins-mailmbox-3.17.3-4.fc30.x86_64 claws-mail-plugins-rssyl-3.17.3-4.fc30.x86_64 claws-mail-3.17.3-4.fc30.x86_64 claws-mail-plugins-attachwarner-3.17.3-4.fc30.x86_64 claws-mail-plugins-newmail-3.17.3-4.fc30.x86_64 claws-mail-plugins-pgp-3.17.3-4.fc30.x86_64 claws-mail-plugins-archive-3.17.3-4.fc30.x86_64 claws-mail-plugins-spam-report-3.17.3-4.fc30.x86_64 claws-mail-plugins-smime-3.17.3-4.fc30.x86_64 claws-mail-plugins-fetchinfo-3.17.3-4.fc30.x86_64 claws-mail-plugins-notification-3.17.3-4.fc30.x86_64 claws-mail-plugins-vcalendar-3.17.3-4.fc30.x86_64 pidgin-2.13.0-9.fc30.x86_64 asunder-2.9.3-5.fc30.x86_64 parole-1.0.1-4.fc30.x86_64 pragha-1.3.3-15.fc30.x86_64 abiword-3.0.2-20.fc30.x86_64 libabiword-3.0.2-20.fc30.x86_64 gnumeric-1.12.44-5.fc30.x86_64
 
# FiraCode Fonts
sudo dnf copr enable evana/fira-code-fonts
sudo dnf install fira-code-fonts
sudo dnf install fedora-workstation-repositories
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate multimedia
sudo dnf groupupdate sound-and-video
sudo dnf install rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted
sudo dnf install vlc
