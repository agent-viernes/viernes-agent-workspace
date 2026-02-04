# HEARTBEAT.md - Tareas Periódicas

## Cada 30 minutos (Heartbeats)

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
   - **REGISTRAR:** Guardar en `memory/lead-tracking.json` la fecha/hora del primer contacto
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
- **REGISTRAR:** Actualizar `memory/lead-tracking.json` marcando el lead como "respondido"

### 3. Revisar Follow-ups Pendientes (24h)
**Lista:** "Leads contactados" en Trello

**Acciones:**
1. Leer `memory/lead-tracking.json` para ver leads contactados
2. Para cada lead con estado "esperando_respuesta":
   - Calcular tiempo transcurrido desde último contacto
   - Si han pasado **24 horas o más** y NO ha respondido:
     - Enviar **Mensaje de Follow-up 1** (24h):
       ```
       Buenas {{nombre}}, estoy pendiente de tu respuesta. ¿Te gustaría que agendemos una llamada rápida para mostrarte cómo funciona?
       ```
     - Actualizar estado a "followup_1_enviado" + timestamp
3. Si han pasado **48 horas** desde follow-up 1 y NO ha respondido:
   - Enviar **Mensaje de Follow-up 2** (48h):
     ```
     {{nombre}}, sé que estás ocupado. ¿Tienes 10 minutos esta semana para una demo rápida? Quedo atenta.
     ```
   - Actualizar estado a "followup_2_enviado" + timestamp
4. Si han pasado **72 horas** (3 días) desde follow-up 2:
   - Enviar **Mensaje Final** (último intento):
     ```
     {{nombre}}, entiendo que ahora no es el mejor momento. Si más adelante te interesa conocer más, aquí estoy. ¡Que tengas un buen día!
     ```
   - Mover carta a "Leads no calificados" en Trello
   - Actualizar estado a "cerrado_sin_respuesta"

### 4. Revisar Mission Control
- Check inbox para tareas pendientes
- Delegar a agentes especializados si es necesario

## Daily (1 vez al día)
- Reportar a Jefe: nuevos leads contactados, demos agendadas, follow-ups enviados

## Prioridad
1. Leads nuevos (contactar dentro de 5 min en horario laboral)
2. Respuestas de leads (responder dentro de 10 min)
3. **Follow-ups 24h** (revisar en cada heartbeat)
4. Mission Control tasks

---
*Notas:*
- Los templates de mensajes están en `vault/👥 Clientes/Templates/lead-messages.md`
- El tracking de leads está en `memory/lead-tracking.json`
