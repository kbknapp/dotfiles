#get fastest mirrors
abbr -a mirror "sudo reflector --country us -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
abbr -a mirrord "sudo reflector --country us --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
abbr -a mirrors "sudo reflector --country us --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
abbr -a mirrora "sudo reflector --country us --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
