#!/bin/bash

INPUT_FILE="index.html"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Ошибка: Исходный файл $INPUT_FILE не найден."
    exit 1
fi
echo "Начало поиска тегов <a>..."
grep -oP '<a.*?>.*?</a>' "$INPUT_FILE"

echo "Поиск завершен."
