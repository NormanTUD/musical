#!/bin/bash

Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

pn () {
	color=$1
	i=0
        for var in "$@"; do
		if [[ "$i" -gt 1 ]]; then
			echo -en "$color$var "
			play -qn synth 2 pluck $var &
			sleep 0.19
		fi
		i=$((i+1))
        done
        wait
	echo -e ""
}

rhythm1 () { pn $1 A A A G G G C C C    E E E G G G D D D; }
rhythm2 () { pn $1 E E A C C G E E A    C C G E E A C A G; }
part2()    { pn $1 A C C G A A A G G E; }
part3()    { pn $1 C C C G D A G A D E; }
part4()    { pn $1 C C C G D A G A D E; }
part1()    { pn $1 A A A G G G E E G E  E E E G G G D D; }

k=1
while [[ 1 ]]; do
	rhythm1 $Yellow
	rhythm2 $Purple
	k=$((k+1))

	if ! ((k % 5)); then
		part4 $Cyan &
	elif ! ((k % 4)); then
		part3 $Blue &
		part2 $Green &
	elif ! ((k % 4)); then
		part2 $Green &
	elif [[ $k == 1 ]]; then
		part1 $Red &
	fi
	wait
done
