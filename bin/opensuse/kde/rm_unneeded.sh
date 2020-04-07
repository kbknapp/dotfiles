#!/bin/bash

function f_rm_unneeded_kde_main() {
    f_out "Removing unneeded KDE applications"

    sudo zypper remove -y kmail kontact kmahjongg konversation ktorrent kmines kget \
        korganizer kamoso juk falkon akregator k3b kaddressbook calligra-core kpat
}
