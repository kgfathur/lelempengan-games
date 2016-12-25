#!/bin/bash
clear
node() {
	ukuran=5
	rowCurs=$1
	colCurs=$2
	for((i=1; i<=$ukuran; i++))
	do
		tput cup $rowCurs $colCurs
		for((j=1; j<=$ukuran; j++))
		do
			if [ "$i" == 1 -o "$j" == 1 -o "$i" == "$ukuran" -o "$j" == "$ukuran"  ]
			then
				echo -ne "\033[42m* "
			else
				echo -ne "  "
			fi
		done
		let rowCurs=$rowCurs+1
	done
	echo -e "\033[0m"
}

awk '{print}' layout

for((x=1; x<=9; x++))
do
	case $x in
	1)
	  bar=1
	  kol=2
	  ;;
	2)
	  bar=1
	  kol=26
	  ;;
	3)
	  bar=1
	  kol=50
	  ;;
	4)
	  bar=13
	  kol=2
	  ;;
	5)
	  bar=13
	  kol=26
	  ;;
	6)
	  bar=13
	  kol=50
	  ;;
	7)
	  bar=25
	  kol=2
	  ;;
	8)
	  bar=25
	  kol=26
	  ;;
	9)
	  bar=25
	  kol=50
	  ;;
	*)
	  ;;
	esac
	node $bar $kol
done
echo
