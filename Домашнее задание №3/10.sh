#!/bin/bash

DATA_FILE="users.txt"

view_user() {
    local user="$1"
    grep "^$user " "$DATA_FILE" || echo "Пользователь $user не найден."
}

add_user() {
    local user="$1"
    local home_dir="$2"
    local creation_date=$(date +%s)
    if grep -q "^$user " "$DATA_FILE"; then
        echo "Пользователь $user уже существует."
    else
        echo "$user $creation_date - $home_dir" >> "$DATA_FILE"
        echo "Пользователь $user добавлен."
    fi
}

delete_user() {
    local user="$1"
    local deletion_date=$(date +%s)
    if grep -q "^$user " "$DATA_FILE"; then
        sed -i "s/^$user \([^ ]\+\) - \([^ ]\+\)/$user \1 $deletion_date \2/" "$DATA_FILE"
        echo "Пользователь $user удален."
    else
        echo "Пользователь $user не найден."
    fi
}

list_users() {
    awk '{print NR ": " $0}' "$DATA_FILE"
}

while getopts "s:c:d:h:a" opt; do
    case $opt in
        s)
            view_user "$OPTARG"
            ;;
        c)
            user_to_create="$OPTARG"
            ;;
        d)
            delete_user "$OPTARG"
            ;;
        h)
            if [ -n "$user_to_create" ]; then
                add_user "$user_to_create" "$OPTARG"
                unset user_to_create
            else
                echo "Ошибка: укажите -c перед -h."
            fi
            ;;
        a)
            list_users
            ;;
        *)
            echo "Неверный аргумент. Используйте: -s, -c, -d, -h, -a."
            ;;
    esac
done
