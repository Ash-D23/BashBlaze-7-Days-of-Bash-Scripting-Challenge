#!/bin/bash

#Check if the argument is passed
if [ $# -eq 0 ] 
then 
    echo "Pass the filename as argument"
    exit 1
fi

log_file=$1

#check if the file exist
if [ ! -f "$log_file" ]; then
    echo "Error: Log file not found: $log_file"
    exit 1
fi

#Total no of lines in the file
lines_count=$(cat $log_file | wc -l)

#No. of Error Messages
error_count=$(grep ERROR logfile.log | wc -l)

#No. of Critical messages
critical_count=$(grep CRITICAL logfile.log | wc -l)
IFS=$'\n'
critical_messages=( $(cat $log_file | awk '{print NR,$0}' | grep CRITICAL) )

#Top 5 Error Messages
top_error_msg=( $(grep ERROR logfile.log | awk -F"-" '{print $3}'| awk '{print $4,$5,$6}' | awk -F"$" '{cnt[$1]+=1} END{for (x in cnt){print cnt[x], x}}' | sort -r | head -n 5) )

current_timestamp=$(date "+%Y-%m-%d-%H-%M-%S")

#Genereate Report
cat > log_report_$current_timestamp.txt <<- "EOF"
Log Report
----------
EOF

#Add Data
echo "Date of Analysis: $current_timestamp" >> log_report_$current_timestamp.txt
echo "File name: $log_report_$current_timestamp.txt" >> log_report_$current_timestamp.txt
echo "Total lines processed: $lines_count" >> log_report_$current_timestamp.txt
echo "Total error count: $error_count" >> log_report_$current_timestamp.txt
echo "Top 5 error messages:" >> log_report_$current_timestamp.txt
echo "---------------------" >> log_report_$current_timestamp.txt
for line in ${top_error_msg[@]}
do
    echo "$line" >> log_report_$current_timestamp.txt
done
echo "Critcal Messages:" >> log_report_$current_timestamp.txt
echo "-----------------" >> log_report_$current_timestamp.txt
for line in ${critical_messages[@]}
do
    echo "$line" >> log_report_$current_timestamp.txt
done