#!/bin/bash
# Google Workspace CLI helper for agent@viernes.ai
# Source this file: source /root/.openclaw/workspace/tools/gworkspace.sh

CREDENTIALS_FILE="/root/.openclaw/credentials/google_workspace.env"

# Load credentials
if [ -f "$CREDENTIALS_FILE" ]; then
    source "$CREDENTIALS_FILE"
else
    echo "Error: Credentials file not found at $CREDENTIALS_FILE"
    return 1
fi

# Gmail functions
gmail_list() {
    local query="${1:-is:unread}"
    local max="${2:-10}"
    curl -s "https://www.googleapis.com/gmail/v1/users/me/messages?q=$query&maxResults=$max" \
        -H "Authorization: Bearer $ACCESS_TOKEN"
}

gmail_get() {
    local msg_id="$1"
    local format="${2:-metadata}"
    curl -s "https://www.googleapis.com/gmail/v1/users/me/messages/$msg_id?format=$format" \
        -H "Authorization: Bearer $ACCESS_TOKEN"
}

gmail_search() {
    local query="$1"
    gmail_list "$query" 20
}

# Calendar functions
calendar_list() {
    curl -s "https://www.googleapis.com/calendar/v3/users/me/calendarList" \
        -H "Authorization: Bearer $ACCESS_TOKEN"
}

calendar_events() {
    local calendar_id="${1:-agent@viernes.ai}"
    local time_min="${2:-$(date -u +%Y-%m-%dT00:00:00Z)}"
    local time_max="${3:-$(date -u -d '+7 days' +%Y-%m-%dT23:59:59Z)}"
    
    # URL encode the calendar_id
    local encoded_id=$(echo "$calendar_id" | sed 's/@/%40/g')
    
    curl -s "https://www.googleapis.com/calendar/v3/calendars/$encoded_id/events?timeMin=$time_min&timeMax=$time_max&singleEvents=true&orderBy=startTime" \
        -H "Authorization: Bearer $ACCESS_TOKEN"
}

calendar_create_event() {
    local calendar_id="${1:-agent@viernes.ai}"
    local summary="$2"
    local start="$3"  # ISO format: 2026-01-31T15:00:00Z
    local end="$4"    # ISO format: 2026-01-31T16:00:00Z
    
    local encoded_id=$(echo "$calendar_id" | sed 's/@/%40/g')
    
    curl -s -X POST "https://www.googleapis.com/calendar/v3/calendars/$encoded_id/events" \
        -H "Authorization: Bearer $ACCESS_TOKEN" \
        -H "Content-Type: application/json" \
        -d "{
            \"summary\": \"$summary\",
            \"start\": { \"dateTime\": \"$start\", \"timeZone\": \"UTC\" },
            \"end\": { \"dateTime\": \"$end\", \"timeZone\": \"UTC\" }
        }"
}

echo "Google Workspace tools loaded for agent@viernes.ai"
echo "Available functions: gmail_list, gmail_get, gmail_search, calendar_list, calendar_events, calendar_create_event"
