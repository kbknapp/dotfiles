wget https://github.com/AppImage/appimaged/releases/download/continuous/appimaged-appimaged-1_alpha-git8e248f5.travis223.x86_64.rpm
dnf install ./appimaged-appimaged-*.rpm
systemctl enable --now --user appimaged
