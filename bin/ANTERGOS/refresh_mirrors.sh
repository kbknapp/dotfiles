#!/bin/bash
ODIR="$(pwd)"
echo -n "Downloading the latest Arch US mirrors..."
cd /etc/pacman.d
mv mirrorlist mirrorlist.backup
curl -Ls https://www.archlinux.org/mirrorlist/\?country\=US | sed -e 's/^#Server/Server/g' > mirrorlist-us
echo "done"
echo -n "Listing Arch mirrors by speed..."
rankmirrors mirrorlist-us > mirrorlist
echo "done"
mv antergos-mirrorlist antergos-mirrorlist.backup
echo -n "Listing Antergos mirrors by speed..."
rankmirrors antergos-mirrorlist.backup > antergos-mirrorlist
echo "done"
exit
cd "${ODIR}"