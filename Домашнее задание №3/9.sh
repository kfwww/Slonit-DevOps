#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Использование: $0 <path> <time>"
  exit 1
fi

path="$1"
time="$2"

if [ ! -d "$path" ]; then
  echo "Такой директории '$path' не существует"
  exit 1
fi

timestamp=$(date -d "$time" +%s)

find "$path" -type f -printf "%T@ %p\n" | while read -r line; do
  file_time=$(echo "$line" | cut -d ' ' -f 1)
  file_name=$(echo "$line" | cut -d ' ' -f 2-)
  
  if [ "$(echo "$file_time < $timestamp" | bc)" -eq 1 ]; then
    echo "$file_name"
  fi
done
