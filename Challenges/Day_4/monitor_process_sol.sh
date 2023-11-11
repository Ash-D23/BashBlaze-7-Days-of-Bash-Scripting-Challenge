#!/bin/bash

restart_process(){
    process_name=$1

    attempts=0
    status=0

    while [ $attempts -le 3 ] && [ $status -eq 0 ]
    do
        echo "Starting the service"
        $(sudo systemctl start $process_name)
        sleep 2
        status=$(pgrep $1 | wc -l)
        attempts=`expr $attempts + 1`
    done

    status=$(pgrep $1 | wc -l)
    if [ $status -gt 0 ]
    then
            echo "Process restarted succesfully"
    else
            echo "Multiple Attempts unsuccesfull"
    fi
}

#check if the arg is present
if [ -z $1 ]
then
        echo "Pass the process name as argument"
else
        #check if the process is running
        status=$(pgrep $1 | wc -l)
        if [ $status -gt 0 ]
        then
                echo "Process is running"
        else
                restart_process $1
        fi
fi