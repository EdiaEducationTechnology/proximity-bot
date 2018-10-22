#!/bin/sh -x

for item in env bin static data
do
    if [ -d $item ]; then
        rm -fr $item
    fi
done

