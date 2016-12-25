#!/bin/bash
clear
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
tput cup 31 0
