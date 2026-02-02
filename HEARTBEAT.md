# HEARTBEAT.md - Tareas Periódicas

## Cada 30 minutos (Heartbeats)

### 1. Revisar Leads en Google Sheets
**Archivo:** "leads agenda viernes demo" en Google Drive  
**Hoja:** "leads global"

**Acciones:**
1. Buscar archivo en Drive: `drive.search` query="leads agenda viernes demo"
2. Leer hoja "leads global": `sheets.getRange` 
3. Para cada lead NUEVO (sin "Estado" o Estado="Pendiente"):
   - Crear archivo de lead en `vault/👥 Clientes/Leads/LEAD-[PHONE]-[NAME].md`
   - Activar agente Natasha: `sessions_spawn` con tarea de contactar lead
   - Actualizar estado en spreadsheet a "Contactado"

**Criterios de nuevo lead:**
- Columna "Estado" vacía, "Pendiente", o "Nuevo"
- Tiene teléfono válido
- No existe archivo de lead en vault

### 2. Revisar Mission Control (Original)
- Check inbox para tareas pendientes
- Delegar a agentes especializados si es necesario

## Daily (1 vez al día)
- Revisar respuestas de leads
- Actualizar estados en spreadsheet
- Reportar a Jefe: nuevos leads contactados, demos agendadas

## Prioridad
1. Leads (contactar dentro de 5 min en horario laboral)
2. Mission Control tasks

---
*Nota: Requiere autenticación activa de Google Workspace*
