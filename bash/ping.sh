#!/bin/bash

# Prompt the user for the input file, number of packets, and time interval
read -p "Enter the name of the input file: " input_file
read -p "Enter the number of packets to send (default: 5): " packet_count
read -p "Enter the time interval between packets in seconds (default: 1): " interval_time

# Set default values if no input is provided
packet_count=${packet_count:-5}
interval_time=${interval_time:-1}

# Create the log file and write the header
log_file="ping_log_$(date +"%Y%m%d_%H%M%S").txt"
echo "Timestamp Hostname/IP Sent Received Lost%" > $log_file

# Loop through the list of hosts and ping each one
while read -r host; do
    # Perform the ping and capture the output
    ping_output=$(ping -c $packet_count -i $interval_time $host)
    
    # Parse the output to extract the relevant data
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    hostname=$(echo "$ping_output" | sed -n '1p' | awk '{print $2}')
    sent=$(echo "$ping_output" | grep -oP '\d+(?= packets transmitted)')
    received=$(echo "$ping_output" | grep -oP '\d+(?= received)')
    lost=$(echo "$ping_output" | grep -oP '\d+(?=% packet loss)')
    
    # Print the results to the console and log file
    if [ $lost -eq 0 ]; then
        echo "$timestamp: $hostname - Ping successful"
    else
        echo "$timestamp: $hostname - Ping failed (lost $lost%)"
    fi
    echo "$timestamp $hostname $sent $received $lost%" >> $log_file
done < "$input_file"