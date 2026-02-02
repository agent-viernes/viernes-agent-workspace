#!/usr/bin/env python3
"""
Instrucciones para Google OAuth Playground
"""
print("""
╔══════════════════════════════════════════════════════════════════╗
║  AUTENTICACIÓN GOOGLE - OAUTH PLAYGROUND                        ║
╚══════════════════════════════════════════════════════════════════╝

PASO 1: Abre en tu navegador
→ https://developers.google.com/oauthplayground

PASO 2: Configurar scopes (en el panel derecho)
Click en el icono de engranaje (⚙️) y asegúrate que esté en:
  ☐ Use your own OAuth credentials

Luego selecciona estos scopes:
  ☑ https://www.googleapis.com/auth/drive.readonly
  ☑ https://www.googleapis.com/auth/spreadsheets.readonly

PASO 3: Autorizar
1. Click en "Authorize APIs"
2. Selecciona tu cuenta: agent@viernes.ai
3. Autoriza los permisos

PASO 4: Obtener Access Token
1. Click en "Exchange authorization code for tokens"
2. Verás un campo "Access token" (empieza con ya29...)
3. Copia TODO el token

PASO 5: Pégalo aquí
Cuando tengas el token, pégalo en el chat y lo configuro inmediatamente.

═══════════════════════════════════════════════════════════════════
""")
