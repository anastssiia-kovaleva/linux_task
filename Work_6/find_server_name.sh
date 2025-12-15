#!/bin/bash

INPUT_FILE="config.txt"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Ошибка: Исходный файл $INPUT_FILE не найден."
    exit 1
fi
echo "Начало поиска активных директив server_name..."
grep -E '^[^#].*server_name.*example\.com' "$INPUT_FILE" | grep -v 'prod-example\.com'

echo "Поиск завершен."
