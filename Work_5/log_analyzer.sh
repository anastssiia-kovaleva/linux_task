#!/bin/bash

# Проверяем наличие исходного файла
if [ ! -f "access.log" ]; then
    echo "Ошибка: Исходный файл access.log не найден."
    exit 1
fi
echo "Начало анализа логов..."

# 1. Извлечение IP-адресов и кодов состояния с помощью awk
echo "1. Извлечение IP-адресов и кодов состояния в status_codes.txt"
awk '{print $1, $9}' access.log > status_codes.txt

echo "   Создан файл status_codes.txt"

# 2. Замена кодов состояния 4xx на "CLIENT_ERROR"
echo "2. Замена кодов 4xx на CLIENT_ERROR в errors.log"
sed -E 's/ ([4][0-9]{2}) / CLIENT_ERROR /g' access.log > errors.log

echo "   Создан файл errors.log"

# 3. Подсчет запросов для каждого уникального IP-адреса
echo "3. Подсчет запросов для каждого уникального IP-адреса:"

# Извлекаем уникальные IP-адреса из status_codes.txt
UNIQUE_IPS=$(awk '{print $1}' status_codes.txt | sort -u)

# Цикл for для подсчета запросов
for IP in $UNIQUE_IPS; do
    # Подсчитываем количество вхождений IP в access.log
    COUNT=$(grep -c "^$IP " access.log)
    echo "   $IP: $COUNT запросов"
done
echo "Анализ завершен."
