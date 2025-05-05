#!/bin/bash

# Get the current_now and voltage_now values
current_now=$(cat /sys/class/power_supply/BATT/current_now)
voltage_now=$(cat /sys/class/power_supply/BATT/voltage_now)

# Calculate the power in watts
power_watts=$(awk "BEGIN {print (${current_now} * ${voltage_now}) / 1000000000000}")

# Format the output for Waybar
output="$(printf "%.3f" $power_watts)"

# Output the result
echo "$output"
