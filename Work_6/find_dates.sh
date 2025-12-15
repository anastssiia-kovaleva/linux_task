#!/bin/bash

INPUT_FILE="dates.log"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Ошибка: Исходный файл $INPUT_FILE не найден."
    exit 1
fi
echo "Начало поиска дат в разных форматах..."
grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}|[0-9]{2}/[0-9]{2}/[0-9]{4}|[0-9]{2}-[0-9]{2}-[0-9]{4}' "$INPUT_FILE"

echo "Поиск завершен."
