#!/bin/bash

# 環境変数が設定されているか確認
if [ -z "$DISCORD_WEBHOOK_URL" ]; then
  echo "Error ⚠️: DISCORD_WEBHOOK_URL is not set"
  exit 1
fi

# 日付を取得(Linux環境での日本時間)
TOMORROW=$(TZ=Asia/Tokyo date -d "tomorrow" "+%m/%d")
# DOW=$(TZ=Asia/Tokyo date -d "tomorrow" "+%w")

# PRタイトル
TITLE="${PR_TITLE:-タイトルなし}"
CONTENT="${PR_BODY:-メッセージなし}"
USER="${PR_USER:-不明なユーザー}"
URL="${PR_URL:-URLなし}"

# WEBHOOK送信
curl -X POST "$DISCORD_WEBHOOK_URL" \
  -H "Content-Type: application/json" \
  -d '
  {
    "username": "PMC Homepage notify",
    "content": "記事が更新されました",
    "embeds": [
        {
            "title": "$TITLE",
            "description": "$CONTENT",
            "url": "$URL",
            "color": 5763719,
            "timestamp": "$TOMORROW",
            "author": {
                "name": "$USER"
            },
            "footer": {
                "text": "PostMineClan"
            }
        }
    ]
}'