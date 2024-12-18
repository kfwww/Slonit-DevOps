#!/bin/bash

PORT=60
LOGFILE="/var/log/port60_listener.log"

log() {
    local message=$1
    local result=$2
    echo "$(date '+%Y-%m-%d %H:%M:%S') $$ $LOCAL_IP $REMOTE_IP \"$message\" \"$result\"" >> "$LOGFILE"
}

nc -lk "$PORT" | while read -r line; do
    LOCAL_IP=$(hostname -I | awk '{print $1}')
    REMOTE_IP=$(sudo netstat -tnp | grep :60 | awk '{print $5}' | cut -d: -f1)


    case "$line" in
        "getDate")
            result=$(date '+%Y-%m-%d %H:%M:%S')
            log "getDate" "$result"
            echo "$result"
            ;;
        "getInetStats")
            result=$(ifconfig)
            log "getInetStats" "Statistics fetched"
            echo "$result"
            ;;
        "getInetStats "*)
            iface=$(echo "$line" | cut -d' ' -f2)
            result=$(ifconfig "$iface" 2>/dev/null || echo "No such interface")
            log "getInetStats $iface" "$result"
            echo "$result"
            ;;
        "bye")
            log "bye" "Session closed"
            echo "Goodbye!"
            break
            ;;
        *)
            log "$line" "Unknown command"
            echo "Unknown command: $line"
            ;;
    esac
done
