#!/usr/bin/env bash
set -e
BASE_DIR="$HOME/bots"
BOT_SCRIPT="$BASE_DIR/universal_bot.py"
LOGS="$BASE_DIR/logs"
mkdir -p "$LOGS"

declare -A BOTS
BOTS[panictab_bot]="7564134625:AAEzOcBSyFcK41PqMj4FCRWA0nLBekbL_70"
BOTS[price_bot]="8411928903:AAHvbnpukpJIXFVCUvu-pkJGwmDREwYRFko"
BOTS[net_panic_bot]="8247573717:AAEWVkxsTFsCzbPGIWwLkfQvcfpAdJromaU"

echo "🔹 Останавливаем старые процессы..."
pkill -f "$BOT_SCRIPT" >/dev/null 2>&1 || true

echo "🔹 Запускаем ботов..."
for NAME in "${!BOTS[@]}"; do
  TOKEN="${BOTS[$NAME]}"
  nohup python3 "$BOT_SCRIPT" --token "$TOKEN" --name "$NAME" > "$LOGS/$NAME.log" 2>&1 &
  echo "✅ $NAME запущен (логи: $LOGS/$NAME.log)"
done

echo "🚀 Все боты стартовали!"
