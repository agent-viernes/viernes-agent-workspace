#!/bin/bash
# leads_processor.sh - Procesa leads desde Google Sheets
# Usage: ./leads_processor.sh

set -e

echo "🔍 Buscando archivo 'leads agenda viernes demo' en Google Drive..."

# Buscar el archivo
FILE_RESULT=$(mcporter call --server google-workspace --tool "drive.search" query="leads agenda viernes demo" 2>/dev/null)

if [ -z "$FILE_RESULT" ] || [ "$FILE_RESULT" == "null" ]; then
    echo "❌ No se encontró el archivo 'leads agenda viernes demo'"
    exit 1
fi

# Extraer ID del archivo
SPREADSHEET_ID=$(echo "$FILE_RESULT" | jq -r '.[0].id // empty')

if [ -z "$SPREADSHEET_ID" ]; then
    echo "❌ No se pudo obtener el ID del spreadsheet"
    exit 1
fi

echo "✅ Spreadsheet encontrado: $SPREADSHEET_ID"

# Leer la hoja "leads global"
echo "📊 Leyendo hoja 'leads global'..."
SHEET_DATA=$(mcporter call --server google-workspace --tool "sheets.getRange" spreadsheetId="$SPREADSHEET_ID" range="leads global!A1:Z1000" 2>/dev/null)

if [ -z "$SHEET_DATA" ]; then
    echo "❌ No se pudo leer la hoja"
    exit 1
fi

# Procesar leads (esto sería más complejo en producción)
echo "✅ Datos obtenidos. Procesando leads..."
echo "$SHEET_DATA" | jq -r '.values[] | @tsv' 2>/dev/null | head -20

echo "✅ Procesamiento completado"
