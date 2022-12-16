#!/usr/bin/env bash

set -euo pipefail

INPUT=${1:-default}

function help(){
    echo "Error: please run with either start or stop"
    exit 1
}


if [ "$INPUT" == "default" ]; then
    help
fi


if [ "$INPUT" != "start" ] && [ "$INPUT" != "stop" ] && [ "$INPUT" != "status" ] ; then
    help
fi

# Check if we're already running and start if not
if [ "$INPUT" == "start" ]; then
    if [ -f "is_running.lock" ]; then
        echo "Error: The build pipeline is already running"
        exit 1
    else
        date -u -Iseconds > is_running.lock
        exit 0
    fi
fi

# Check for the file and tidy up
if [ "$INPUT" == "stop" ]; then
    if [ -f "is_running.lock" ]; then
        rm is_running.lock
        exit 0
    else
        echo "Pipeline not running"
    fi
fi


# Display the current status
if [ "$INPUT" == "status" ]; then
    if [ -f "is_running.lock" ]; then
        echo "Pipeline running since $(cat is_running.lock)"
        exit 0
    else
        echo "Pipeline not running"
        exit 0
    fi
fi

