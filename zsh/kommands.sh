function k {
    case $1 in
    skip)
        n=$(($2 + 1))
        cut -d ' ' -f $n -
        ;;
    col)
        awk -v col=$2 '{print $col}'
        ;;
    howto)
        grep $2 -r ~/.dotfiles/howtos -A 2 -h | sed -e '/```/d'
        ;;
    update)
        sudo pacman -Syy
        ;;
    upgrade)
        sudo pacman -Syu --noconfirm
        ;;
    refresh-mirrors)
        cd /etc/pacman.d
        echo "Downloading the latest US mirrors..."
        sudo mv mirrorlist mirrorlist.backup
        sudo sh -c "curl -L https://www.archlinux.org/mirrorlist/\?country\=US | sed -e 's/^#Server/Server/g' > mirrorlist-us"
        echo "Listing Arch mirrors by speed..."
        sudo sh -c "rankmirrors mirrorlist-us > mirrorlist"
        sudo mv antergos-mirrorlist antergos-mirrorlist.backup
        echo "Listing Antergos mirrors by speed..."
        sudo sh -c "rankmirrors antergos-mirrorlist.backup > antergos-mirrorlist"
        ;;
    *)
    	echo "col <num> where num is the column of output to display"
    	echo "skip <num> where num is the number of space deliminated values to skip"
    	;;
    esac
}
