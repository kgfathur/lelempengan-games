#!/bin/bash
add(){
    sum=$(($1+$2))
    return $sum
}

read -p "Enter an integer: " int1
read -p "Enter an integer: " int2
add $int1 $int2
echo "The result is: " $?
