#!/bin/bash

system_metrics(){
    cpu_usage=$(top -bn 1 | awk 'NR==2 {print $2}')
    memory_usage=$(free | awk 'NR==2 {print ($3/$2)*100}')
    disk_usage=$(df -h /| head -n 2 | awk 'NR==2 {print $5}')

    echo "--- System Metrics ---"
    echo "CPU Usage: $cpu_usage"
    echo "Memory Usage: $memory_usage"
    echo "Disk Space Used: $disk_usage"
}

monitor_service(){
    echo "---- Monitor a Specific Service ----"
    read -p "Enter the service name to monitor: " service_name
    service_status=$(systemctl is-active $service_name)
    if [ $service_status = active ]
    then 
        echo "$service_name is running"
    else
        echo "$service_name is not running"
        read -p "Do you want to restart $service_name [Y/N] " answer
        if [ $answer = "Y" ] || [ $answer = "y" ]
        then
            $(sudo systemctl start $service_name )
            echo "restarting $service_name..."
            sleep 2
            service_status=$(systemctl is-active $service_name)
            if [ $service_status=active ]
            then 
                echo "$service_name restarted succesfully"
            else
                echo "$service_name restart unsuccesfull"
            fi
        fi
    fi
}

while true; do
    echo "---- Monitoring Metrics Script ----"
    echo "1. View System Metrics"
    echo "2. Monitor a Specific Service"
    echo "3. Exit"

    read -p "Enter your choice (1, 2, or 3): " choice

    case $choice in
        1)
            system_metrics
            ;;
        2)
            monitor_service
            ;;
        3)
            echo "Exiting the script!!!"
            exit 0
            ;;
        *)
            echo "Error: Invalid option. Please choose a valid option (1, 2, or 3)."
            ;;
    esac

    sleep 5
done