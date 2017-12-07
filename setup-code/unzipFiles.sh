#!/bin/bash
# A script to automate the download of all the Citibikes data

IFS=$'\n'       # make newlines the only separator
set -f          # disable globbing
for link in $(cat < "$1"); do
    unzip "$link"
done
