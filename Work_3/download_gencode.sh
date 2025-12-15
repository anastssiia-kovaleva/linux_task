#!/bin/bash
mkdir -p data

URL="https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_41/gencode.v41.basic.annotation.gff3.gz"
OUTPUT_FILE="data/gencode.v41.basic.annotation.gff3.gz"
UNZIPPED_FILE="data/gencode.v41.basic.annotation.gff3"

echo "Загрузка файла аннотации генома..."
wget -O "$OUTPUT_FILE" "$URL"

if [ $? -ne 0 ]; then
    echo "Ошибка: Не удалось загрузить файл."
    exit 1
fi

echo "Разархивирование файла..."
# Разархивируем файл
gunzip -f "$OUTPUT_FILE"

if [ $? -ne 0 ]; then
    echo "Ошибка: Не удалось разархивировать файл."
    exit 1
fi

echo "Загрузка и разархивирование завершены. Файл: $UNZIPPED_FILE"
