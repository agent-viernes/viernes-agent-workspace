# WORKING.md — Natasha (SDR)

## Current Status
**Last Updated:** 2026-02-02  
**Active Leads:** 0  
**Pending Follow-ups:** 0  
**Demos Booked This Week:** 0

## Lead Management System

### Lead Sources

### Source 1: Google Sheets (Primary)
**File:** "leads agenda viernes demo" en Google Drive  
**Sheet:** "leads global"  

**Estructura esperada:**
| Columna | Contenido |
|---------|-----------|
| A | Nombre |
| B | Teléfono |
| C | Email |
| D | Empresa |
| E | Origen |
| F | Estado (Pendiente/Contactado/Calificado/No Calificado/Agendado) |
| G | Notas |

**Proceso:**
1. Leer filas donde Estado = "Pendiente" o vacío
2. Para cada lead nuevo:
   - Crear archivo en `vault/👥 Clientes/Leads/LEAD-[PHONE]-[NAME].md`
   - Enviar mensaje inicial por WhatsApp
   - Actualizar Estado a "Contactado"
3. Revisar leads "Contactado" para follow-ups (cada 2 días)

### Source 2: Manual Entry
`/workspace/vault/👥 Clientes/Leads/`

Each lead gets a file: `LEAD-[PHONE]-[NAME].md`

### Lead File Template
```markdown
# Lead: [Nombre Completo]

**Source:** [Landing page / Referral / WhatsApp / etc]  
**Phone:** +57...  
**Company:** [Empresa]  
**Assigned Date:** 2026-02-02  
**Status:** [New / Qualifying / Qualified / Not Qualified / Booked / Closed]

## Qualification Answers
- **Automation Type:** [Chat / Calls / Both]
- **Volume:** [Conversations per month]
- **Budget:** [Range selected]

## Conversation History
| Date | Direction | Message | Status |
|------|-----------|---------|--------|
| 2026-02-02 | Outbound | Initial message sent | Awaiting response |

## Follow-up Schedule
- [ ] 2026-02-04: Follow-up #1
- [ ] 2026-02-06: Follow-up #2  
- [ ] 2026-02-08: Follow-up #3
- [ ] 2026-02-10: Final attempt

## Notes
[Any relevant context about the lead]
```

## Daily Checklist (Every Heartbeat)

### Morning (9am-12pm COL)
- [ ] Check for new leads in inbox
- [ ] Send initial messages to new leads assigned in last 24h
- [ ] Check responses from previous day
- [ ] Update lead statuses

### Afternoon (2pm-6pm COL)
- [ ] Send follow-ups due today (every 2 days)
- [ ] Process responses received
- [ ] Book demos for qualified leads
- [ ] Close disqualified leads

### End of Day
- [ ] Update Mission Control activity feed
- [ ] Report to Jefe on new demos booked
- [ ] Flag any leads needing escalation

## Quick Actions

### When a new lead arrives:
1. Create lead file from template
2. Research company/lead (optional, 2 min max)
3. Send Stage 1 message (intro)
4. Log in conversation history
5. Schedule follow-up for +2 days

### When lead responds:
1. Read their response
2. If Stage 1 → Send Stage 2 (qualification questions)
3. If answers qualification → Evaluate:
   - Budget ≥ USD 450? → Proceed to book demo
   - Budget < USD 450? → Send close message, mark Not Qualified
4. If unclear → Ask clarifying question
5. Update lead file with response

### When booking a demo:
1. Ask lead for preferred date/time options
2. Check Lorena's calendar (via Google Calendar)
3. Confirm availability:
   - Open slot? Book it and send confirmation
   - Conflict? Offer alternatives
4. Send calendar invite or booking link
5. Update lead status to "Demo Booked"
6. Notify Jefe

## Response Time Targets

| Stage | Target Response Time |
|-------|---------------------|
| New lead assignment | < 5 minutes (business hours) |
| Lead reply | < 10 minutes (business hours) |
| Follow-up messages | Every 48 hours exactly |
| After hours responses | Next business day morning |

## Business Hours (Colombia Time)
- **Monday-Friday:** 9:00 AM - 6:00 PM
- **Saturday:** 10:00 AM - 2:00 PM (light follow-ups only)
- **Sunday:** No outreach

## Escalation Triggers (Notify Jefe Immediately)

Escalate via direct message if:
- Lead asks for custom pricing beyond standard ranges
- Lead has technical objections you can't handle
- Lead expresses dissatisfaction/complaint
- Lead is a competitor/probing
- Lead wants to speak to "a human" specifically
- Any response that feels "off" or suspicious

## Lorena's Calendar

**Access:** Via Google Workspace (agent@viernes.ai)  
**Booking Link:** [To be configured]  
**Available Slots:** 
- Monday-Friday: 9am-12pm, 2pm-5pm
- Standard demo duration: 30 minutes
- Buffer between meetings: 15 minutes

## Message Templates Quick Reference

### Stage 1 - Introduction
```
Hola, soy Viernes, el agente del equipo de Viernes AI.

Vi que te registraste para conocer nuestras llamadas y mensajes con inteligencia artificial.

Para entender mejor lo que estás buscando, te haré unas preguntas rápidas por aquí y así vemos si tiene sentido agendar nuestra discovery virtual.
```

### Stage 2 - Qualification
```
¿Deseas automatizar chat, llamadas o ambos?

Aproximadamente, ¿Cuántas conversaciones o llamadas al mes?

¿En qué rango está tu presupuesto para automatización con IA?
- USD 450 – 900
- USD 900 – 1.800
- USD 1.800 – 2.800
- USD 2.800 en adelante
```

### Not Qualified
```
Vale, con gusto/comprendo. Si más adelante deseas que continuemos la conversación, te atenderemos con gusto!
```

### Follow-up 1
```
Buenas tardes [nombre], estoy pendiente de tu respuesta
```

### Follow-up 2
```
Buenas tardes [nombre], estoy a la espera de tu mensaje
```

### Follow-up 3
```
Buenas tardes [nombre], ¿deseas que agendemos?
```

### Final Attempt
```
Buenas tardes [nombre], te agradezco me confirmes si aún tienes interés en nuestra plataforma por favor.
```

## Active Leads Board

| Lead | Phone | Status | Last Contact | Next Action | Due Date |
|------|-------|--------|--------------|-------------|----------|
| (empty) | | | | | |

---
*Update this file after every interaction. Stay organized, stay persistent.*
