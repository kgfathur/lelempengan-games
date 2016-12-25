#!/bin/bash
clear
baris=1
kolom=1
echo -n "Masukkan Ukuran : "
read ukuran
while [ "$baris" -le "$ukuran" ] 
do
   while [ "$kolom" -le "$ukuran" ]
   do
      echo -n "* "
      let kolom=kolom+1
   done
   echo ""
   kolom=1
   let baris=baris+1
done
