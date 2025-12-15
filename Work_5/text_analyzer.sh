#!/bin/bash

INPUT_FILE="text.txt"
OUTPUT_FILE="top5_words.txt"

# Проверяем наличие исходного файла
if [ ! -f "$INPUT_FILE" ]; then
    echo "Ошибка: Исходный файл $INPUT_FILE не найден."
    exit 1
fi

echo "Начало анализа текстовых данных..."

# 1. Приведение к нижнему регистру и удаление знаков препинания с помощью sed
echo "1. Очистка текста и приведение к нижнему регистру..."

CLEAN_TEXT=$(cat "$INPUT_FILE" | \
    sed 's/[[:punct:]]/ /g' | \
    tr ' ' '\n' | \
    sed '/^$/d' | \
    tr '[:upper:]' '[:lower:]')

# 2. Подсчет частоты слов и вывод ТОП-5 с помощью awk
echo "2. Подсчет частоты слов и вывод ТОП-5 в $OUTPUT_FILE..."
echo "$CLEAN_TEXT" | \
    awk '
    { count[$0]++ }
    END {
        for (word in count) {
            print count[word], word
        }
    }' | \
    sort -nr | \
    head -n 5 | \
    awk '{print $2 ": " $1}' > "$OUTPUT_FILE"

echo "   Создан файл $OUTPUT_FILE с ТОП-5 словами."

# 3. Получение определений для ТОП-5 слов с помощью curl
echo "3. Получение определений для ТОП-5 слов:"

# Читаем слова из файла
while IFS=": " read -r WORD COUNT; do
    echo "--- Слово: $WORD (встречается $COUNT раз) ---"
    
    API_URL="https://api.dictionaryapi.dev/api/v2/entries/en/$WORD"
    
    # Отправляем запрос и извлекаем первое определение
    DEFINITION=$(curl -s "$API_URL" | \
        jq -r '.[0].meanings[0].definitions[0].definition' 2>/dev/null )
    if [ -z "$DEFINITION" ] || [ "$DEFINITION" == "null" ]; then
        echo "   Определение не найдено или ошибка API."
    else
        echo "   Определение: $DEFINITION"
    fi
done < "$OUTPUT_FILE"

echo "Анализ завершен."
