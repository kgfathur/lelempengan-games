#!/bin/bash

main() {
	tput cup 31 0
	echo -e "\t\t\tgames : player $player main"
	read -d'' -s -n1 input
	
	abaikanInput="0"
	case $input in
		7)
			row="2" col="3" ;;
		8)
			row="2" col="27" ;;
		9)
			row="2" col="51" ;;
		4)
			row="14" col="3" ;;
		5)
			row="14" col="27" ;;
		6)
			row="14" col="51" ;;
		1)
			row="26" col="3" ;;
		2)
			row="26" col="27" ;;
		3)
			row="26" col="51"	;;
		*)
			abaikanInput="1" ;;

	esac
	
	if [ "$abaikanInput" != "1" ]; then
		tulis $play $row $col;
	fi
}

initPlayer() {
	if [ "$player" == 1 ]
	then
		player=2;
		play="man2"
	else
		player=1;
		play="man1"
	fi
}

tulis() {
	r=$2
	c=$3
	if [ $1 == "man1" ]; then
		echo -e "\033[44m"
	elif [ $1 == "man2" ]; then
		echo -e "\033[43m"
	fi

	awk 'BEGIN {b='$r'; c='$c';}
	{
		system("tput cup " b " " c)
		print
		b+=1
	}' $play

	echo -e "\033[0m"
	tput cup 31 0
}

layout() {
	awk '{print}' layout1
	echo -e "\033[42m"
	awk 'BEGIN {
		for(i=2; i<5; i++) {
			for(j=3; j<58; j+=24) {
				system("tput cup " i " " j)
				printf "       "
				system("tput cup " i+12 " " j)
				printf "       "
				system("tput cup " i+24 " " j)
				printf "       "
			}
		}
	}'
	echo -e "\033[0m"
}

player=1
play="man1"
runGames=true
clear
layout;
while $runGames
do
	main;
	initPlayer;
done
