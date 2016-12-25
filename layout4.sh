#!/bin/bash
clear
baris=1
kolom=1
#echo -n "Masukkan Ukuran (ganjil) : "
#read ukuran
ukuran=$1
mean=$((($ukuran/2)+1))
echo ""
echo ""
while [ "$baris" -le "$ukuran" ] 
do
   echo -n "    "
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
