#!/bin/bash

INPUT_FILE="config.json"
OUTPUT_FILE="config.env"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Ошибка: Исходный файл $INPUT_FILE не найден."
    exit 1
fi

echo "Начало трансформации конфигурационного файла..."

# 1. Преобразование в формат "ключ=значение"
echo "1. Преобразование в формат ключ=значение..."
sed -E 's/[{}" ]//g; s/,/\n/g' "$INPUT_FILE" > "$OUTPUT_FILE.tmp"

# 2. Добавление префикса "CONF_" с помощью awk
echo "2. Добавление префикса CONF_..."
awk '{print "CONF_"$0}' "$OUTPUT_FILE.tmp" > "$OUTPUT_FILE"

rm "$OUTPUT_FILE.tmp"

echo "   Создан файл $OUTPUT_FILE"
echo ""

# 3. Экспорт переменных среды с помощью цикла for
echo "3. Экспорт переменных среды (только для текущей сессии скрипта):"
for LINE in $(cat "$OUTPUT_FILE"); do
    export "$LINE"
    echo "   Экспортирована: $LINE"
done

echo ""
echo "Проверка экспорта (только внутри скрипта):"
echo "CONF_HOST: $CONF_host"
echo "CONF_PORT: $CONF_port"
echo "CONF_DEBUG: $CONF_debug"

echo "Трансформация завершена."
