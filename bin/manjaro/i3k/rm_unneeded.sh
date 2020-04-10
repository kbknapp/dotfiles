#!/bin/bash

function f_rm_unneeded_i3k_main() {
  f_out "Removing unneeded KDE applications"

  sudo pacman -Rnss yakuake kmail kontact kmahjongg konversation ktorrent kmines kget \
        korganizer kamoso juk falkon akregator k3b kaddressbook calligra-core kpat || true
}
