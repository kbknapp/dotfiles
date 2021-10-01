#!/bin/sh

#cpupower frequency-info -fm | grep -oP '(?<=frequency: )([^ ]+ [^ ]+)'
MHZ=$(head -n10 /proc/cpuinfo | grep "cpu MHz" | awk '{print $4/1000}')
printf "%.2f GHz" $MHZ
