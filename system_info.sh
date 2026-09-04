#!/bin/bash

current_date=$(date)
host_name=$(hostname)
current_user=$(whoami)
echo "Current date : $current_date"
echo "Hostname : $host_name"
echo "Current user: $current_user"
echo ""
echo "--- Disk Usage ---"
df -h
echo ""
echo "--- Top 10 Running Processes ---"
ps aux | head -n 10

read -p "Enter a name for your report directory: " dir_name
mkdir -p "$dir_name"
touch "$dir_name/testProcess.txt"
ps aux > "$dir_name/testProcess.txt"
echo "Report directory '$dir_name' created and processes logged to '$dir_name/testProcess.txt'."
