#!/bin/bash

# Get the current connection status
connection_status=$(mullvad status | grep "Connected")

# Format the output for Waybar
output="$ip_address"

# Output the result
echo "$output"
