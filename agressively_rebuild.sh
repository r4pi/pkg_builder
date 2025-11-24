#!/usr/bin/env bash
#
# This script completely rebuilds all the packages in the pkg set.

while true
do
    if [ -f is_running.lock ]; then
        rm is_running.lock
    fi
    ./run_cron.sh 2>&1 >> cron.log
    sleep $(shuf -i 1-120 -n 1)
done


