#!/bin/bash

RED='\033[31m'
GREEN='\033[32m'
BLUE='\033[34m'
RESET='\033[0m'

if [ -z "$1" ]; then
  echo -e "${RED}Ошибка:${RESET} не указан IP-адрес"
  exit 1
fi

IP=$1

LOG_FILE="ping_trace_log.txt"

ping -c 3 $IP > /dev/null
if [ $? -eq 0 ]; then
  STATUS="${GREEN}Доступен${RESET}"
else
  STATUS="${RED}Не доступен${RESET}"
fi

echo -e "${BLUE}1.${RESET} [$(date)] Пинг к $IP: $STATUS" >> $LOG_FILE

echo -e "${BLUE}2.${RESET} [$(date)] Трассировка до $IP:" >> $LOG_FILE
traceroute $IP >> $LOG_FILE

ROUTER=$(traceroute -m 3 $IP | awk 'NR==2 {print $2}')
if [ -n "$ROUTER" ]; then
  echo -e "${BLUE}3.${RESET} [$(date)] Маршрут получен с роутера: $ROUTER" >> $LOG_FILE
else
  echo -e "${BLUE}3.${RESET} [$(date)] Не удалось определить роутер" >> $LOG_FILE
fi

echo -e "Результаты записаны в $LOG_FILE"
