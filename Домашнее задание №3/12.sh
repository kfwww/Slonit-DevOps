#!/bin/bash

INPUT=$1
OUTPUT=$2

if [[ -f "$INPUT" && -f "$OUTPUT" ]]; then
    echo "Оба файла существуют"
    exit 1
elif [[ ! -f "$INPUT" ]]; then
    echo "Входной файл не существует"
    exit 1
fi

# Читаем входной файл, меняем строки местами и записываем в выходной файл
awk '{line[NR]=$0} END {for(i=1; i<=NR; i+=2) {if(line[i+1]) print line[i+1]; print line[i]}}' "$INPUT" > "$OUTPUT"

cat $2