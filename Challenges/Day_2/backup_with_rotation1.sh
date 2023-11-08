#!/bin/bash

path=$1
echo "Source path: $path"

current_timestamp=$(date "+%Y-%m-%d-%H-%M-%S")

mkdir -p $path/backups

final_filename=$1/backups/backup_$current_timestamp.tgz
echo "final path: $final_filename"

tar czf $final_filename -C $path .

filecount=$(ls -l $path/backups | wc -l)

echo "no of files: $filecount"

if [ $filecount -gt 4 ]
then
    rmfilename=$(ls -tr $path/backups | head -n 1)
    echo "file to be removed: $rmfilename"
    rm $path/backups/$rmfilename 
fi

