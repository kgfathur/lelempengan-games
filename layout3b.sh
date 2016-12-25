#!/bin/bash
clear
baris=1
kolom=1
echo -n "Masukkan Ukuran (ganjil) : "
read ukuran
let mean=($ukuran/2)+1
while [ "$baris" -le "$ukuran" ] 
do
   #let diag=($ukuran-($baris-1))
   while [ "$kolom" -le "$ukuran" ]
   do
	   if [ $baris = $kolom -o $baris = 1 -o $kolom = 1 -o $baris = $ukuran -o $kolom = $ukuran -o $baris = $mean -o $kolom = $mean ]
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
