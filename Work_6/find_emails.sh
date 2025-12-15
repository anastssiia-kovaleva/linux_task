#!/bin/bash

INPUT_FILE="user_activity.log"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Ошибка: Исходный файл $INPUT_FILE не найден."
    exit 1
fi
echo "Начало поиска валидных email-адресов..."
grep -oE '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' "$INPUT_FILE"

echo "Поиск завершен."
