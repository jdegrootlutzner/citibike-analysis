#!/bin/bash
# A script to automate the split of all the Citibikes data

IFS=$'\n'       # make newlines the only separator
set -f          # disable globbing
var=0
for link in $(cat < "$1"); do
    let var=var+1
    sed -n 1~2p $link > output$var.csv
done
