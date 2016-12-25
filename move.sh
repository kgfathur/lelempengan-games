#!/bin/bash

while true
do
read -d'' -s -n1 input  # read input

index=10  # init with nonexistent
case $input in
  7) index="11";;
  8) index="12";;
  9) index="13";;
  4) index="21";;
  5) index="22";;
  6) index="23";;
  1) index="31";;
  2) index="32";;
  3) index="33";;
esac
echo " nilai index = $index"
done
