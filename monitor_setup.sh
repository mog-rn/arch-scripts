#!/bin/bash

# Usage function to display help for the script
usage() {
    echo "Usage: $0 [connect|disconnect]"
    exit 1
}

# Check for the argument
if [ $# -ne 1 ]; then
    usage
fi

ACTION=$1
PRIMARY_MONITOR=$(xrandr --query | grep " primary" | cut -d" " -f1)
SECONDARY_MONITOR=$(xrandr --query | grep " connected" | grep -v " primary" | cut -d" " -f1)

# Function to connect the secondary monitor
connect_monitor() {
    if [ ! -z "$SECONDARY_MONITOR" ]; then
        xrandr --output "$SECONDARY_MONITOR" --auto --right-of "$PRIMARY_MONITOR"
        echo "Secondary monitor connected."
    else
        echo "No secondary monitor detected."
    fi
}

# Function to disconnect the secondary monitor
disconnect_monitor() {
    if [ ! -z "$SECONDARY_MONITOR" ]; then
        xrandr --output "$SECONDARY_MONITOR" --off
        echo "Secondary monitor disconnected."
    else
        echo "No secondary monitor detected."
    fi
}

# Execute the action based on the argument
case $ACTION in
    connect)
        connect_monitor
        ;;
    disconnect)
        disconnect_monitor
        ;;
    *)
        usage
        ;;
esac

