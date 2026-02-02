#!/usr/bin/env python3
"""
OAuth Flow para Google Workspace
Genera URL de autorización y espera el código
"""
import http.server
import socketserver
import urllib.parse
import webbrowser
import json

# Configuración - Usando cliente de Google OAuth Playground
CLIENT_ID = "407408718192.apps.googleusercontent.com"  # OAuth Playground
REDIRECT_URI = "http://localhost:8080/oauth2callback"
SCOPES = [
    "https://www.googleapis.com/auth/drive.readonly",
    "https://www.googleapis.com/auth/spreadsheets.readonly"
]

# Construir URL de autorización
auth_url = (
    "https://accounts.google.com/o/oauth2/v2/auth?"
    f"client_id={CLIENT_ID}&"
    f"redirect_uri={urllib.parse.quote(REDIRECT_URI)}&"
    f"scope={urllib.parse.quote(' '.join(SCOPES))}&"
    "response_type=code&"
    "access_type=offline&"
    "prompt=consent"
)

print("=" * 70)
print("FLUJO DE AUTENTICACIÓN GOOGLE WORKSPACE")
print("=" * 70)
print()
print("1. Abre esta URL en tu navegador:")
print()
print(auth_url)
print()
print("2. Inicia sesión con: agent@viernes.ai")
print("3. Autoriza los permisos")
print("4. Serás redirigido a localhost (error esperado)")
print("5. Copia el 'code' de la URL de redirección")
print("6. Pégalo aquí")
print()
print("=" * 70)
