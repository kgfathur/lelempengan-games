#!/bin/bash
baris=1
kolom=1
ukuran=11
while let "baris <= $ukuran"
do 
  echo  $baris mantap
  let "baris=baris+1"
done
