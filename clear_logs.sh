#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob  # *.log yoksa boş array döndür

LOG_DIR="logs"
ARCHIVE_DIR="${LOG_DIR}/archive"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

mkdir -p "$LOG_DIR" "$ARCHIVE_DIR"

# Log dosyalarını array olarak al
LOG_FILES=("$LOG_DIR"/*.log)

if [ ${#LOG_FILES[@]} -gt 0 ]; then
    echo "Log dosyaları bulunuyor. Arşivleniyor..."
    # tar'a sadece dosya adlarını gönder
    tar -czf "${ARCHIVE_DIR}/logs_${TIMESTAMP}.tar.gz" -C "$LOG_DIR" -- "${LOG_FILES[@]##*/}"
    rm -f "$LOG_DIR"/*.log
    echo "Arşiv oluşturuldu: ${ARCHIVE_DIR}/logs_${TIMESTAMP}.tar.gz"
else
    echo "Temizlenecek .log dosyası yok."
fi

shopt -u nullglob

