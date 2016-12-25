#!/bin/bash
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
				echo -n "* "
			else
				echo -n "  "
			fi
		done
		let rowCurs=$rowCurs+1
	done
	echo
}

#clear
for((x=1; x<=9; x++))
do
	case $x in
	1)
	  bar=1
	  kol=2
	  ;;
	2)
	  bar=1
	  kol=32
	  ;;
	3)
	  bar=1
	  kol=62
	  ;;
	4)
	  bar=16
	  kol=2
	  ;;
	5)
	  bar=16
	  kol=32
	  ;;
	6)
	  bar=16
	  kol=62
	  ;;
	7)
	  bar=31
	  kol=2
	  ;;
	8)
	  bar=31
	  kol=32
	  ;;
	9)
	  bar=31
	  kol=62
	  ;;
	*)
	  ;;
	esac
	node $bar $kol
done
