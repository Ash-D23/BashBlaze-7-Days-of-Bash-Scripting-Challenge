#!/bin/bash

echo "Welcome to the Interactive File and Directory Explorer!"

echo "Files and Directories in the Current Path:"

ls -l

    
echo "Enter a line of text (Press Enter without text to exit):"

read word


while [ -n $word ]
do

    count=$(echo $word | wc -m);

    echo "count is $count"

        
    echo "Enter a line of text (Press Enter without text to exit):"

    read word
done

echo "Exiting the Interactive Explorer. Goodbye!"