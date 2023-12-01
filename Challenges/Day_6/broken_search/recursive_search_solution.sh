#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: ./recursive_search.sh <directory> <target_file>"
  exit 1
fi

search_directory=$1
target_file=$2

function recursive_search(){
    dir=$1
    local target_file=$2

    for file in $dir/*
    do
        if [ -d "$file" ]
        then
            recursive_search $file $target_file
        fi
        if [ -f "$file" ] && [ $(basename $file) = $target_file ]
        then
            echo "File found at location: $file"
            exit 1
        fi
    done
}


recursive_search $search_directory $target_file