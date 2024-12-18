#!/bin/bash

read -p "Введите путь до блочного устройства: " block_device

if [ ! -b "$block_device" ]; then
    echo "Указанный путь $block_device не является блочным устройством."
    exit 1
fi

if mount | grep -q "$block_device"; then
    echo "Устройство $block_device уже примонтировано."
    exit 90
else
    mount_dir=$(mktemp -d)
    mount "$block_device" "$mount_dir"
    if [ $? -eq 0 ]; then
        echo "Устройство $block_device успешно примонтировано в $mount_dir."
    else
        echo "Ошибка при монтировании устройства $block_device."
        rmdir "$mount_dir"
        exit 1
    fi
fi
