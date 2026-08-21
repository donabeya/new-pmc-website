#!/bin/bash

# 環境変数が設定されているか確認
if [ -z "$DISCORD_WEBHOOK_URL" ]; then
  echo "Error ⚠️: DISCORD_WEBHOOK_URL is not set"
  exit 1
fi

# 日付を取得
TIMESTAMP=$(TZ=Asia/Tokyo date --iso-8601=seconds)

# PRタイトル
TITLE="${PR_TITLE:-タイトルなし}"
CONTENT="${PR_BODY:-メッセージなし}"
USER="${PR_USER:-不明なユーザー}"
URL="${PR_URL:-URLなし}"

PAYLOAD=$(jq -n \
  --arg title "$TITLE" \
  --arg description "$CONTENT" \
  --arg url "$URL" \
  --arg user "$USER" \
  --arg timestamp "$TIMESTAMP" \
  '{
    username: "PMC Homepage notify",
    content: "記事が更新されました",
    embeds: [
      {
        title: $title,
        description: $description,
        url: $url,
        color: 5763719,
        "timestamp": $timestamp,
        author: {
          name: $user
        },
        footer: {
          text: "PostMineClan"
        }
      }
    ]
  }')

curl -X POST "$DISCORD_WEBHOOK_URL" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD"