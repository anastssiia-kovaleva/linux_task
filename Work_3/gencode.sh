#!/bin/bash

INPUT_FILE="data/gencode.v41.basic.annotation.gff3"
OUTPUT_DIR="terminal_task/results"
OUTPUT_FILE="$OUTPUT_DIR/result.tsv"
mkdir -p "$OUTPUT_DIR"
echo "Создана директория: $OUTPUT_DIR"

echo "Начало обработки файла: $INPUT_FILE"

# 2. Преобразование файла .gff в таблицу аннотации
awk '
BEGIN { FS="\t"; OFS="\t" }
$3 == "gene" && $9 ~ /gene_type=unprocessed_pseudogene/ {
    match($9, /gene_name=([^;]+)/, arr);
    gene_name = arr[1];
    print $1, $4, $5, $7, gene_name
}' "$INPUT_FILE" | \

# 3. Модификация полученной таблицы
awk '
BEGIN { FS="\t"; OFS="\t" }
{
    chr = $1;
    start = $2;
    end = $3;
    strand = $4;
    name = $5;

    if (strand == "+") {
        new_start = start;
        new_end = start + 1;
    } else if (strand == "-") {
        new_start = end;
        new_end = end + 1;
    } else {
        new_start = start;
        new_end = end;
    }

    # Выводим результат
    print chr, new_start, new_end, strand, name
}' > "$OUTPUT_FILE"

echo "Обработка завершена. Результат записан в: $OUTPUT_FILE"
