#!/bin/bash

# Проверка наличия аргумента
if [ -z "$1" ]; then
    echo "Ошибка: Не указан файл. Использование: $0 <путь_к_файлу>"
    exit 1
fi

FILE_PATH="$1"
# Извлекаем только имя файла из полного пути
FILE_NAME=$(basename "$FILE_PATH")

# Проверка существования файла и того, что это обычный файл
if [ -f "$FILE_PATH" ]; then
    LINK_NAME="${FILE_NAME}.symlink"
    ln -s "$FILE_PATH" "$LINK_NAME"
    
    if [ $? -eq 0 ]; then
        echo "Успех: Создана мягкая ссылка '$LINK_NAME' на файл '$FILE_PATH'."
    else
        echo "Ошибка: Не удалось создать мягкую ссылку."
        exit 2
    fi
else
    # Файл не существует или не является обычным файлом
    echo "Ошибка: Файл '$FILE_PATH' не существует или не является обычным файлом."
    exit 3
fi
