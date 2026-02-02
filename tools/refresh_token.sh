#!/bin/bash
# Script para refrescar token de Google
# Lee refresh_token desde archivo de credenciales

CREDENTIALS_FILE="$HOME/.config/google-workspace-mcp/credentials.json"

# Leer refresh_token del archivo
if [ -f "$CREDENTIALS_FILE" ]; then
    REFRESH_TOKEN=$(jq -r '.refresh_token' "$CREDENTIALS_FILE" 2>/dev/null)
else
    echo "Error: Credentials file not found"
    exit 1
fi

if [ -z "$REFRESH_TOKEN" ] || [ "$REFRESH_TOKEN" == "null" ]; then
    echo "Error: No refresh_token found in credentials"
    exit 1
fi

echo "Token refresh would use refresh_token from credentials file"
echo "(Client ID and Secret must be configured separately)"
