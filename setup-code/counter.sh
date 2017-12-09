#!/bin/bash
# A script to count the rows of multiple files

IFS=$'\n'       # make newlines the only separator
set -f          # disable globbing
total=0
for link in $(cat < "$1"); do
    temp=$(sed -n '$=' $link)
    let total=total+temp
    echo $link
    echo "file count $temp"
    echo "total count $total"
done
