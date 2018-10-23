#!/bin/sh -x

for item in env bin static
do
    if [ -d $item ]; then
        rm -fr $item
    fi
done


