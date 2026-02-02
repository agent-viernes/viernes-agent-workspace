# TOOLS.md - Local Notes

Skills define *how* tools work. This file is for *your* specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:
- Camera names and locations
- SSH hosts and aliases  
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras
- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH
- home-server → 192.168.1.100, user: admin

### TTS
- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

### Google Workspace
Account: `agent@viernes.ai`
Status: ✅ Connected (Gmail + Calendar)

**Tools:**
- Script: `/root/.openclaw/workspace/tools/gworkspace.sh`
- Credentials: `/root/.openclaw/credentials/google_workspace.env`

**Usage:**
```bash
source /root/.openclaw/workspace/tools/gworkspace.sh

# Gmail
gmail_list "is:unread" 5
gmail_get "MESSAGE_ID"
gmail_search "from:someone@example.com"

# Calendar
calendar_list
calendar_events "agent@viernes.ai"
calendar_create_event "agent@viernes.ai" "Meeting" "2026-02-01T10:00:00Z" "2026-02-01T11:00:00Z"
```

---

Add whatever helps you do your job. This is your cheat sheet.
