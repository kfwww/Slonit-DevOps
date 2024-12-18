#!/bin/bash

read -p "Введите имя пользователя: " username

if ! id "$username" &>/dev/null; then
    echo "Пользователь $username не существует."
    exit 1
fi

user_shell=$(getent passwd "$username" | cut -d: -f7)
user_home=$(getent passwd "$username" | cut -d: -f6)
user_groups=$(id -nG "$username")

echo "Шелл пользователя: $user_shell"
echo "Домашняя директория: $user_home"
echo "Список групп: $user_groups"

read -p "Что вы хотите изменить? (uid/home/group): " option

case $option in
    uid)
        read -p "Введите новый uid: " new_uid
        while getent passwd | cut -d: -f3 | grep -q "^$new_uid$"; do
            echo "UID $new_uid уже занят"
            read -p "Введите новый uid: " new_uid
        done
        echo "Команда для смены UID: usermod -u $new_uid $username"
        ;;
    home)
        read -p "Введите новую домашнюю директорию: " new_home
        read -p "Переместить текущую домашнюю директорию? (Y/N): " move_home
        if [ "$move_home" == "Y" ]; then
            echo "Команда для смены домашней директории и перемещения файлов: usermod -m -d $new_home $username"
        else
            echo "Команда для смены домашней директории без перемещения файлов: usermod -d $new_home $username"
        fi
        ;;
    group)
        read -p "Изменить основную (1) или дополнительную (2) группу? (1/2): " group_type
        if [ "$group_type" == "1" ]; then
            read -p "Введите название новой основной группы: " new_group
            echo "Команда для смены основной группы: usermod -g $new_group $username"
        else
            read -p "Введите название новой дополнительной группы: " new_group
            echo "Команда для добавления в новую группу: usermod -aG $new_group $username"
        fi
        ;;
    *)
        echo "Неизвестный вариант."
        ;;
esac