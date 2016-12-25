#!/bin/bash
initLayout() {
	clear
	baris=1
	kolom=1
	#echo -n "Masukkan Ukuran (ganjil) : "
	#read ukuran
	ukuran=25
	mean=$((ukuran/2+1))
	echo ""
	echo ""
	echo ""
	while [ "$baris" -le "$ukuran" ] 
	do
	   echo -n "      "
	   diagonal=$(($ukuran-($baris-1)))
	   while [ "$kolom" -le "$ukuran" ]
	   do
		   if [ $baris = $kolom -o $baris = 1 -o $kolom = 1 -o $baris = $ukuran -o $kolom = $ukuran -o $baris = $mean -o $kolom = $mean -o $kolom = $diagonal ]
		   then
			echo -n "* "
		   else
			echo -n "  "
		   fi
	      let kolom=kolom+1
	   done
	   echo ""
	   kolom=1
	   let baris=baris+1
	done
	echo ""
	echo ""
}

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

initLayout;

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
