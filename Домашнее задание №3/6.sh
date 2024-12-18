#!/bin/bash

source ./config.sh

function show_help {
    echo "Использование: $0 [-h] [-p PERCENT]"
    echo "  -h        Вывод этой справки"
    echo "  -p        Указать процент свободного места (например, 10)"
    exit 0
}

PERCENT=0
while getopts ":hp:" opt; do
    case ${opt} in
        h )
            show_help
            ;;
        p )
            PERCENT=$OPTARG
            ;;
        \? )
            echo "Ошибка: Неверный параметр"
            show_help
            ;;
    esac
done

if ! [[ "$PERCENT" =~ ^[0-9]+$ ]] || [ "$PERCENT" -le 0 ] || [ "$PERCENT" -gt 100 ]; then
    echo "Ошибка: Процент должен быть числом от 1 до 100."
    exit 1
fi

df -h | awk -v percent="$PERCENT" '
BEGIN { low_space = 0 }
/\/$/ {
    gsub("%", "", $5);
    if ($5 > (100 - percent)) {
        print "Раздел:", $1, "имеет только", 100 - $5, "% свободного места.";
        low_space = 1;
    }
}
END {
    exit low_space;
}' | while read -r line; do
    curl -s -X POST https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage \
        -d chat_id=$TELEGRAM_CHAT_ID \
        -d text="$line"
done
