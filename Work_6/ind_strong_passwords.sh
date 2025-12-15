#!/bin/bash

INPUT_FILE="passwords.txt"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Ошибка: Исходный файл $INPUT_FILE не найден."
    exit 1
fi
echo "Начало поиска сложных паролей..."
grep -P '^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^a-zA-Z0-9\s]).{8,}$' "$INPUT_FILE"

echo "Поиск завершен."
