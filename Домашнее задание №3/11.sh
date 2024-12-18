#!/bin/bash

if [ -z "$1" ]; then
    echo "Использование: $0 <PID/имя программы>"
    exit 1
fi

SERVICE="$1"

LOG_FILE="checker.log"

log_status() {
    local status=$1
    local timestamp=$(date +"%d-%m-%Y %H-%M-%S")
    echo "$timestamp mySvcChecker: service $SERVICE $status" >> "$LOG_FILE"
}

while true; do
    if [[ "$SERVICE" =~ ^[0-9]+$ ]]; then
        if ps -p "$SERVICE" > /dev/null 2>&1; then
            log_status "isUP"
        else
            log_status "isDown"
        fi
    else
        if pgrep -x "$SERVICE" > /dev/null 2>&1; then
            log_status "isUP"
        else
            log_status "isDown"
        fi
    fi
    sleep 5
done
