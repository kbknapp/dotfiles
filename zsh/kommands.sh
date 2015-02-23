function k {
    LBIN="${HOME}"/.dotfiles/bin/"${K_OS}"
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
        sudo sh "${LBIN}"/update.sh
        ;;
    upgrade)
        sudo sh "${LBIN}"/upgrade.sh
        ;;
    refresh-mirrors)
        sudo sh "${LBIN}"/refresh_mirrors.sh
        ;;
    *)
    	echo "col <num> where num is the column of output to display"
        echo "skip <num> where num is the number of space deliminated values to skip"
	    echo "update"
	    echo "upgrade"
	    echo "refresh-mirrors"
    	;;
    esac
}
