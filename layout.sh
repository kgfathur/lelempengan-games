#!/bin/bash
array2d="1.1:1.2:1.3 2.1:2.2 3.1:3.2:3.3:3.4"

function process2ndDimension {
    for dimension2 in $*
    do
        echo -n $dimension2 "   "
    done
    echo
}

function process1stDimension {
    for dimension1 in $array2d
    do
        process2ndDimension `echo $dimension1 | tr : " "`
    done
}

process1stDimension
