#!/bin/bash

if [ -z "$1" ]; then
  echo -e "Использование: ./0.sh <имя_файла>"
  exit 1
fi

name="$1"
file="$name.sh"

if [ -e "$file" ]; then
  echo "Файл '$file' уже существует."
  exit 1
fi

echo "#!/bin/bash" > "$file"
echo "Файл '$file' создан."

chmod +x "$file"
echo "Права на выполнение установлены."

nano "$file"

echo "Команда для запуска скрипта: ./$file"
