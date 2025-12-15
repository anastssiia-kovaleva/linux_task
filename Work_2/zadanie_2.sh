#!/bin/bash

# 1. Проверка наличия двух аргументов
if [ "$#" -ne 2 ]; then
    echo "Ошибка: Неверное количество аргументов."
    echo "Использование: $0 <путь_к_файлу> <организм>"
    echo "Поддерживаемые организмы: human, mouse, rat, fly"
    exit 1
fi

FILE_PATH="$1"
ORGANISM="$2"
FILE_NAME=$(basename "$FILE_PATH")

# 2. Проверка существования файла
if [ ! -f "$FILE_PATH" ]; then
    echo "Ошибка: Файл '$FILE_PATH' не существует."
    exit 2
fi

# 3. Проверка организма
case "$ORGANISM" in
    human|mouse|rat|fly)
        # Успех: файл существует и организм поддерживается
        echo "Обрабатываю $FILE_NAME"
        ;;
    *)
        # Ошибка: организм не поддерживается
        echo "Ошибка: Организм '$ORGANISM' не поддерживается."
        echo "Поддерживаемые организмы: human, mouse, rat, fly"
        exit 3
        ;;
esac
