#!/bin/bash

cat << 'EOF' > gen.sh
#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Использование: $0 <использование> <кол-во файлов> <маска имени файла>"
    exit 1
fi

USAGE=$1
AMOUNT=$2
MASK=$3

LOCK_FILE="${0}.lock"

if [ -f "$LOCK_FILE" ]; then
    cat "$LOCK_FILE"
    exit 64
else
    echo $$ > "$LOCK_FILE"
fi

cd /root || exit 1

PIPE="/tmp/pipe_$$"
mkfifo "$PIPE"

for i in $(seq 1 "$AMOUNT"); do
    FILE_SIZE=$((RANDOM % 790 + 10))
    dd if=/dev/urandom of="${MASK}_$i" bs=1K count="$FILE_SIZE" &> /dev/null
done

tar -cf "${PIPE}" ${MASK}_* &
cat "${PIPE}" > /tmp/archive_$$.tar
rm -f "${PIPE}"

ls -p | grep -v / | tee /tmp/file_list_$$.txt

END_TIME=$(date +%s)
echo "Скрипт завершен за: $END_TIME"

rm -f "$LOCK_FILE"
EOF

chmod +rx gen.sh

echo "Скрипт 'gen.sh' создан"
