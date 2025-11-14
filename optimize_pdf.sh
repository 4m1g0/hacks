#!/bin/bash

# Compress PDF using Ghostscript
# Usage: ./compress_pdf.sh input.pdf output.pdf [level]
# Available levels: screen, ebook, printer, prepress, default
# Example: ./compress_pdf.sh big.pdf small.pdf ebook

# Check if Ghostscript is installed
if ! command -v gs >/dev/null 2>&1; then
  echo "❌ Ghostscript is not installed. Install it with: sudo apt install ghostscript"
  exit 1
fi

# Check arguments
if [ $# -lt 2 ]; then
  echo "Usage: $0 input.pdf output.pdf [level]"
  echo "Available levels: screen, ebook, printer, prepress, default"
  exit 1
fi

input="$1"
output="$2"
level="${3:-ebook}"  # default compression level: ebook

# Run Ghostscript
echo "🔧 Compressing '$input' → '$output' with level '$level'..."

gs -sDEVICE=pdfwrite \
   -dCompatibilityLevel=1.4 \
   -dPDFSETTINGS=/$level \
   -dNOPAUSE -dQUIET -dBATCH \
   -sOutputFile="$output" "$input"

if [ $? -eq 0 ]; then
  original_size=$(du -h "$input" | cut -f1)
  new_size=$(du -h "$output" | cut -f1)
  echo "✅ Done. Original size: $original_size → New size: $new_size"
else
  echo "❌ Error while compressing the PDF."
fi
