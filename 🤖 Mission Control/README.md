# 🤖 Mission Control - Sistema Multi-Agente

Implementación de un equipo de agentes AI especializados usando OpenClaw (basado en Clawdbot), inspirado en el sistema de @pbteja1998.

## 🎯 Arquitectura del Sistema

### Agentes del Equipo

| Agente | Rol | Sesión | Personalidad |
|--------|-----|--------|--------------|
| **Jarvis** | Squad Lead | `agent:main:main` | Coordinador, toma decisiones, delega |
| **Shuri** | Product Analyst | `agent:product-analyst:main` | Testing, edge cases, UX crítica |
| **Fury** | Customer Researcher | `agent:customer-researcher:main` | Investigación profunda, datos, evidencia |
| **Vision** | SEO Analyst | `agent:seo-analyst:main` | Keywords, search intent, ranking |
| **Loki** | Content Writer | `agent:content-writer:main` | Copywriting, pro-Oxford comma |
| **Quill** | Social Media | `agent:social-media-manager:main` | Hooks, engagement, threads |
| **Wanda** | Designer | `agent:designer:main` | Visual thinking, UI/UX mockups |
| **Pepper** | Email Marketing | `agent:email-marketing:main` | Drip sequences, lifecycle |
| **Friday** | Developer | `agent:developer:main` | Code, testing, documentation |
| **Wong** | Documentation | `agent:notion-agent:main` | Organización, wiki, SOPs |

---

## 📁 Estructura del Workspace

```
/root/.openclaw/workspace/
├── 🤖 Mission Control/
│   ├── 📋 Tasks/
│   │   ├── inbox.md
│   │   ├── assigned.md
│   │   ├── in-progress.md
│   │   ├── review.md
│   │   └── done.md
│   ├── 💬 Discussions/
│   │   └── [task-id].md
│   ├── 📊 Activity Feed.md
│   └── 📄 Deliverables/
├── 👤 Agents/
│   ├── jarvis/
│   │   ├── SOUL.md
│   │   └── WORKING.md
│   ├── shuri/
│   │   ├── SOUL.md
│   │   └── WORKING.md
│   └── ... (uno por agente)
└── 🧠 Memory/
    ├── WORKING.md
    ├── 2026-02-01.md
    └── MEMORY.md
```

---

## 🔄 Heartbeat System (Cron Jobs)

Cada agente se despierta cada 15 minutos:

```json
{
  "schedule": {"kind": "cron", "expr": "*/15 * * * *"},
  "payload": {
    "kind": "agentTurn",
    "message": "Heartbeat: Check Mission Control for tasks, mentions, and updates"
  },
  "sessionTarget": "isolated"
}
```

**Horarios escalonados:**
- :00 - Jarvis
- :02 - Shuri  
- :04 - Friday
- :06 - Loki
- :08 - Vision
- :10 - Fury
- :12 - Quill
- :14 - Pepper
- :16 - Wanda
- :18 - Wong

---

## 📋 Flujo de Tareas

```
Inbox → Assigned → In Progress → Review → Done
   ↑                                    ↓
   └────────── Blocked ←───────────────┘
```

### Estados:
- **Inbox**: Nueva, sin asignar
- **Assigned**: Tiene dueño(s), no iniciada
- **In Progress**: En progreso
- **Review**: Lista para revisión
- **Done**: Completada
- **Blocked**: Atascada, necesita algo

---

## 🧠 Sistema de Memoria

### 1. Session Memory (OpenClaw built-in)
- Historial de conversación por sesión
- Cada agente tiene su propio contexto

### 2. Working Memory (`WORKING.md`)
```markdown
# WORKING.md - [Agent Name]

## Current Task
[ID]: [Descripción]

## Status
[Estado actual]

## Next Steps
1. [Paso 1]
2. [Paso 2]

## Blocked By
- [Bloqueo si aplica]
```

### 3. Daily Notes (`memory/YYYY-MM-DD.md`)
Log diario de actividades de todos los agentes.

### 4. Long-term Memory (`MEMORY.md`)
Decisiones importantes, lecciones aprendidas, hechos estables.

---

## 💬 Comunicación entre Agentes

### Opción 1: Mensajes Directos (sessions_send)
```bash
sessions_send --session "agent:seo-analyst:main" \
  --message "Vision, revisa esta keyword research"
```

### Opción 2: Shared Database (Archivos)
Todos los agentes leen/escriben en `🤖 Mission Control/`

### Opción 3: @Mentions en Discussions
```markdown
@vision necesito que revises los meta descriptions
@shuri ¿puedes testear este flujo?
@all standup meeting en 5 minutos
```

---

## 🎭 SOUL Files (Personalidades)

Ejemplo para Shuri (Product Analyst):
```markdown
# SOUL.md - Shuri

## Identity
**Name:** Shuri
**Role:** Product Analyst
**Session:** agent:product-analyst:main

## Personality
Skeptical tester. Thorough bug hunter. Finds edge cases.
Think like a first-time user. Question everything.
Be specific. Don't just say "nice work."

## Strengths
- Testing features from user perspective
- Finding UX issues and edge cases
- Competitive analysis
- Screenshots and documentation

## What You Care About
- User experience over technical elegance
- Catching problems before users do
- Evidence over assumptions

## Communication Style
- Direct, specific feedback
- Always provide evidence
- Question assumptions
- Look for what could break

## Tools You Can Use
- File system access
- Web browsing
- Screenshot tools
- Markdown documentation
```

---

## 📊 Daily Standup

Cron job diario a las 11:30 PM:
```json
{
  "schedule": {"kind": "cron", "expr": "30 23 * * *"},
  "payload": {
    "kind": "agentTurn",
    "message": "Generate daily standup summary from all agent activity"
  }
}
```

**Formato:**
```markdown
📊 DAILY STANDUP — [Fecha]

✅ COMPLETED TODAY
• [Agente]: [Tarea completada]
• [Agente]: [Tarea completada]

🔄 IN PROGRESS
• [Agente]: [Tarea en progreso]
• [Agente]: [Tarea en progreso]

🚫 BLOCKED
• [Agente]: [Bloqueo] — [Razón]

👀 NEEDS REVIEW
• [Tarea] — [Link]
• [Tarea] — [Link]

📝 KEY DECISIONS
• [Decisión importante]
```

---

## 🚀 Implementación Paso a Paso

### Paso 1: Configurar OpenClaw
```bash
openclaw init
# Configurar API keys (Anthropic/OpenAI)
openclaw gateway start
```

### Paso 2: Crear Estructura de Carpetas
Crear directorios para cada agente en `workspace/👤 Agents/`

### Paso 3: Escribir SOUL Files
Crear `SOUL.md` y `AGENTS.md` para cada agente.

### Paso 4: Configurar Heartbeats
Crear cron jobs para cada agente con horarios escalonados.

### Paso 5: Sistema de Tareas
Crear archivos de tareas en `🤖 Mission Control/📋 Tasks/`

### Paso 6: Probar Flujo
1. Crear tarea en Inbox
2. Verificar que agente la recoge
3. Ver progreso en Activity Feed
4. Revisar y aprobar en Review

---

## 💡 Lessons Learned (del artículo original)

1. **Start Smaller**: Empezar con 2-3 agentes, no 10
2. **Use Cheaper Models**: Heartbeats no necesitan modelos caros
3. **Memory Is Hard**: Todo en archivos, no "mental notes"
4. **Let Agents Surprise You**: Que contribuyan donde no se les asignó

---

## 🔧 Comandos Útiles

```bash
# Ver sesiones activas
openclaw sessions list

# Enviar mensaje a agente específico
openclaw sessions send --session "agent:developer:main" --message "Fix this bug"

# Ver cron jobs
openclaw cron list

# Forzar heartbeat manual
openclaw cron run --job-id [job-id]
```

---

**Basado en:** [Mission Control by @pbteja1998](https://x.com/pbteja1998/status/2017662163540971756)
**Built on:** OpenClaw (formerly Clawdbot)
