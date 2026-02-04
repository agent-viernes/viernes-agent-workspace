#!/bin/bash
# trello_leads_processor.sh
# Procesa leads de Trello y envía mensajes usando templates

set -e

# Load credentials from .env file
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/trello.env" ]; then
    source "$SCRIPT_DIR/trello.env"
else
    echo "❌ Error: No se encontró trello.env"
    exit 1
fi

# Validate credentials are set (not the placeholder values)
if [[ "$TRELLO_KEY" == "REEMPLAZAR_CON_API_KEY" ]] || [[ -z "$TRELLO_KEY" ]]; then
    echo "❌ Error: TRELLO_KEY no configurado en trello.env"
    exit 1
fi

if [[ "$TRELLO_TOKEN" == "REEMPLAZAR_CON_TOKEN" ]] || [[ -z "$TRELLO_TOKEN" ]]; then
    echo "❌ Error: TRELLO_TOKEN no configurado en trello.env"
    exit 1
fi

# Templates path
TEMPLATE_FILE="/root/.openclaw/workspace/vault/👥 Clientes/Templates/lead-messages.md"

echo "🔍 Revisando leads nuevos en Trello..."

# Get cards from "Leads nuevos" list
CARDS=$(curl -s "https://api.trello.com/1/lists/${TRELLO_LIST_NUEVOS}/cards?key=${TRELLO_KEY}&token=${TRELLO_TOKEN}")

# Check if jq is available
if ! command -v jq > /dev/null 2>&1; then
    echo "⚠️  Instalando jq..."
    apt-get update > /dev/null 2>&1 && apt-get install -y jq > /dev/null 2>&1
fi

# Count cards
CARD_COUNT=$(echo "$CARDS" | jq 'length')

if [[ "$CARD_COUNT" -eq 0 ]] || [[ "$CARDS" == "[]" ]]; then
    echo "✅ No hay leads nuevos para procesar"
    exit 0
fi

echo "📋 Encontrados $CARD_COUNT lead(s) para procesar"

# Process each card
echo "$CARDS" | jq -c '.[]' | while read -r card; do
    CARD_ID=$(echo "$card" | jq -r '.id')
    CARD_NAME=$(echo "$card" | jq -r '.name')
    CARD_DESC=$(echo "$card" | jq -r '.desc')
    
    # Skip template cards
    if [[ "$CARD_NAME" == *"Empieza a usar Trello"* ]]; then
        echo "⏭️  Ignorando carta de plantilla: $CARD_NAME"
        continue
    fi
    
    echo "📋 Procesando lead: $CARD_NAME"
    
    # Parse name and company from description
    # Format expected: "Nombre: Yasmin Mojica\nEmpresa: Totalteam\nTeléfono: +573214516510"
    NOMBRE=$(echo "$CARD_DESC" | grep -i "^Nombre:" | sed 's/Nombre://i' | sed 's/^[[:space:]]*//' | head -1)
    EMPRESA=$(echo "$CARD_DESC" | grep -i "^Empresa:" | sed 's/Empresa://i' | sed 's/^[[:space:]]*//' | head -1)
    TELEFONO=$(echo "$CARD_DESC" | grep -i "^Teléfono:" | sed 's/Tel[eé]fono://i' | sed 's/^[[:space:]]*//' | head -1)
    
    # Fallback: try to parse from card name (format: "Name - Company")
    if [[ -z "$NOMBRE" && "$CARD_NAME" == *" - "* ]]; then
        NOMBRE=$(echo "$CARD_NAME" | cut -d'-' -f1 | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        EMPRESA=$(echo "$CARD_NAME" | cut -d'-' -f2- | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    fi
    
    # If still no name, use card name as name
    if [[ -z "$NOMBRE" ]]; then
        NOMBRE="$CARD_NAME"
    fi
    
    # If no company, use generic
    if [[ -z "$EMPRESA" ]]; then
        EMPRESA="su empresa"
    fi
    
    echo "   👤 Nombre: $NOMBRE"
    echo "   🏢 Empresa: $EMPRESA"
    echo "   📱 Teléfono: $TELEFONO"
    
    # Check if template file exists
    if [ ! -f "$TEMPLATE_FILE" ]; then
        echo "   ❌ Error: No se encontró template en $TEMPLATE_FILE"
        continue
    fi
    
    # Load Message 1 template and replace variables
    MENSAJE=$(cat "$TEMPLATE_FILE" | awk '/### Mensaje 1/,/```/' | grep -v "###\|^```" | sed "s/{{nombre}}/$NOMBRE/g" | sed "s/{{empresa}}/$EMPRESA/g")
    
    if [[ -z "$MENSAJE" ]]; then
        echo "   ❌ Error: No se pudo cargar el template del Mensaje 1"
        continue
    fi
    
    echo "   💬 Mensaje preparado:"
    echo "$MENSAJE" | head -5
    
    # Here you would trigger Natasha agent with the prepared message
    # For now, just output what would happen
    if [[ -n "$TELEFONO" ]]; then
        echo "   🚀 Próximo paso: Activar Natasha para enviar mensaje a $TELEFONO"
    else
        echo "   ⚠️  No se encontró teléfono en la descripción del card"
        continue
    fi
    
    # Move card to "Leads contactados"
    echo "   📁 Moviendo carta a 'Leads contactados'..."
    MOVE_RESULT=$(curl -s -X PUT "https://api.trello.com/1/cards/${CARD_ID}?idList=${TRELLO_LIST_CONTACTADOS}&key=${TRELLO_KEY}&token=${TRELLO_TOKEN}")
    
    if echo "$MOVE_RESULT" | jq -e '.id' > /dev/null 2>&1; then
        echo "   ✅ Carta movida exitosamente"
    else
        echo "   ⚠️  No se pudo mover la carta"
    fi
    
    # Add delay to prevent WhatsApp blocking
    echo "   ⏳ Esperando 30 segundos antes del siguiente lead..."
    sleep 30
    
done

echo "✅ Procesamiento de leads completado"
