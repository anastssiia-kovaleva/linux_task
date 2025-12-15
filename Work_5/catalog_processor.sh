#!/bin/bash

INPUT_FILE="products.csv"
AVAILABLE_FILE="available_products.csv"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Ошибка: Исходный файл $INPUT_FILE не найден."
    exit 1
fi

echo "Начало обработки каталога..."

# 1. Расчет общей стоимости по категориям и сортировка
echo "1. Расчет общей стоимости товаров на складе по категориям:"
awk '
BEGIN { FS=","; OFS="\t" }
NR>1 { total[$3] += $4 * $5 }
END {
    for (category in total) {
        print total[category], category
    }
}' "$INPUT_FILE" | sort -nr | awk '{print $2 ": " $1}'

echo ""

# 2. Удаление товаров с Stock=0 с помощью sed
echo "2. Удаление товаров с Stock=0 в $AVAILABLE_FILE..."
(head -n 1 "$INPUT_FILE" && sed '/,0$/d' "$INPUT_FILE") > "$AVAILABLE_FILE"

echo "   Создан файл $AVAILABLE_FILE"
echo ""

# 3. Цикл while для вывода названий товаров с ценой > 100
echo "3. Товары с ценой выше 100:"

tail -n +2 "$AVAILABLE_FILE" | while IFS=, read -r ID Name Category Price Stock; do
    IS_EXPENSIVE=$(echo "$Price > 100" | bc -l)
    
    if [ "$IS_EXPENSIVE" -eq 1 ]; then
        echo "   $Name (Цена: $Price)"
    fi
done

echo "Обработка завершена."
