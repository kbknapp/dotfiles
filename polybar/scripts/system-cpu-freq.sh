#!/bin/sh

#cpupower frequency-info -fm | grep -oP '(?<=frequency: )([^ ]+ [^ ]+)'
MHZ=$(lscpu | grep "CPU MHz" | awk '{print $3/1000}')
printf "%.2f GHz" $MHZ
