#!/usr/bin/env bash
set -euo pipefail

title="$1"
intro="$2"
details="$3"
button="$4"
url="$5"
payload="${RUNNER_TEMP:-/tmp}/teams-payload.json"

jq -n \
  --arg title "$title" \
  --arg subtitle "${GITHUB_REPOSITORY:-ocean-ds/ocean-ios} · ${GITHUB_WORKFLOW:-CD} · ${GITHUB_SHA:0:7}" \
  --arg intro "$intro" \
  --arg details "$details" \
  --arg button "$button" \
  --arg url "$url" \
  --arg run "${GITHUB_SERVER_URL:-https://github.com}/${GITHUB_REPOSITORY:-ocean-ds/ocean-ios}/actions/runs/${GITHUB_RUN_ID:-0}" \
  '{
    type: "message",
    attachments: [{
      contentType: "application/vnd.microsoft.card.adaptive",
      content: {
        "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
        type: "AdaptiveCard",
        version: "1.4",
        body: ([
          { type: "TextBlock", text: $title, weight: "Bolder", size: "Medium", wrap: true },
          { type: "TextBlock", text: $subtitle, isSubtle: true, spacing: "None", wrap: true },
          { type: "TextBlock", text: $intro, wrap: true }
        ] + (if $details != "" then [ { type: "TextBlock", text: $details, wrap: true, fontType: "Monospace" } ] else [] end)),
        actions: ([ { type: "Action.OpenUrl", title: $button, url: $url } ]
          + (if $url != $run then [ { type: "Action.OpenUrl", title: "Ver o CD", url: $run } ] else [] end))
      }
    }]
  }' > "$payload"

if [ -z "${TEAMS_WEBHOOK_URL:-}" ]; then
  echo "::warning::MOBILE_REVIEW_ALERT_TEAMS_WEBHOOK não configurado; card só no log."
  cat "$payload"
  exit 0
fi

curl -sS --fail-with-body -X POST -H "Content-Type: application/json" \
  -d @"$payload" "$TEAMS_WEBHOOK_URL"
