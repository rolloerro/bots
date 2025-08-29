#!/usr/bin/env bash
BASE_DIR="$HOME/bots"
BOT_SCRIPT="$BASE_DIR/universal_bot.py"

echo "🛑 Останавливаем ботов..."
pkill -f "$BOT_SCRIPT" >/dev/null 2>&1 || true
echo "✅ Все боты остановлены"
