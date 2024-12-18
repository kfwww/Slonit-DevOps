#!/bin/bash

read -p "Введите название файла: " filename

if [ -z "$filename" ]; then
  echo "Название файла не может быть пустым"
  exit 1
fi

if [ -e "$filename" ]; then
  echo "Файл '$filename' уже существует"
  exit 1
fi

touch "$filename"

read -p "Введите права доступа для файла (в формате 777): " permissions

if [[ ! "$permissions" =~ ^[0-7]{3}$ ]]; then
  echo "Неверный формат прав доступа. Права должны быть в формате 777"
  exit 1
fi

chmod "$permissions" "$filename"
echo "Права доступа $permissions установлены для файла $filename"