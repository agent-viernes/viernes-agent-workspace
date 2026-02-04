# HEARTBEAT.md - Tareas Periódicas

## Cada 15 minutos (Heartbeats)

### 1. Revisar Leads en Trello
**Board:** "Administrativo"  
**Lista:** "Leads nuevos"  
**Templates:** `vault/👥 Clientes/Templates/lead-messages.md`

**Acciones:**
1. Leer cartas en lista "Leads nuevos":
   ```bash
   curl -s "https://api.trello.com/1/lists/6980fb5211959d198d49792a/cards?key=$TRELLO_KEY&token=$TRELLO_TOKEN"
   ```
2. Para cada lead NUEVO (ignorar cartas de plantilla como "Empieza a usar Trello"):
   - Parsear nombre y empresa de la descripción o título
   - Cargar template del Mensaje 1 desde `vault/👥 Clientes/Templates/lead-messages.md`
   - Reemplazar variables: `{{nombre}}`, `{{empresa}}`
   - Activar agente Natasha con los datos parseados y el mensaje ya preparado
   - Mover carta a lista "Leads contactados"
3. Esperar 30-60 segundos entre cada contacto (protección anti-bloqueo WhatsApp)

**Formato esperado en descripción del card:**
```
Nombre: Yasmin Mojica
Empresa: Totalteam
Teléfono: +573214516510
```

**O en el título:** `"Nombre - Empresa"` (ej: "Yasmin - Totalteam")

### 2. Revisar Respuestas de Leads
- Check mensajes entrantes de leads contactados
- Si lead responde → activar Natasha con Mensaje 2 (calificación)
- Actualizar carta en Trello si califica/no califica

### 3. Revisar Mission Control
- Check inbox para tareas pendientes
- Delegar a agentes especializados si es necesario

## Daily (1 vez al día)
- Revisar follow-ups pendientes (cada 2 días)
- Reportar a Jefe: nuevos leads contactados, demos agendadas

## Prioridad
1. Leads nuevos (contactar dentro de 5 min en horario laboral)
2. Respuestas de leads (responder dentro de 10 min)
3. Mission Control tasks

---
*Nota: Los templates de mensajes están en `vault/👥 Clientes/Templates/lead-messages.md`*
