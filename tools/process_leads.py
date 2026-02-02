#!/usr/bin/env python3
"""
Procesa leads desde Google Sheets
Lee token desde archivo de credenciales (NO hardcoded)
"""
import json
import urllib.request
import os
import ssl

# Leer token desde archivo de credenciales
CREDENTIALS_FILE = os.path.expanduser("~/.config/google-workspace-mcp/credentials.json")

def get_access_token():
    try:
        with open(CREDENTIALS_FILE, 'r') as f:
            creds = json.load(f)
            return creds.get('access_token')
    except Exception as e:
        print(f"Error reading credentials: {e}")
        return None

def get_sheet_data(spreadsheet_id):
    access_token = get_access_token()
    if not access_token:
        print("No access token found")
        return None
    
    url = f"https://sheets.googleapis.com/v4/spreadsheets/{spreadsheet_id}/values/leads%20global"
    req = urllib.request.Request(url, headers={"Authorization": f"Bearer {access_token}"})
    
    ctx = ssl.create_default_context()
    with urllib.request.urlopen(req, context=ctx) as response:
        return json.loads(response.read().decode())

if __name__ == "__main__":
    # ID del spreadsheet (se pasa como argumento o se configura aquí)
    SPREADSHEET_ID = "1XJ4TSr9ISkPUceKjsolBVTW9LNwWOtekwkgFSq5ico4"
    
    data = get_sheet_data(SPREADSHEET_ID)
    if data:
        print(json.dumps(data, indent=2))
