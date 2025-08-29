#!/usr/bin/env bash
set -e

echo "▶️ Подготовка и запуск всех 4 ботов на M4…"

# Список ботов: путь к папке, скрипт и requirements
BOTS=(
  "fdt_bot fdt_bot.py requirements.txt"
  "panic_bot panic_bot.py requirements.txt"
  "price_bot price_bot.py requirements.txt"
  "net_panic_bot bot.py requirements.txt"
)

for BOT in "${BOTS[@]}"; do
  FOLDER=$(echo $BOT | awk '{print $1}')
  SCRIPT=$(echo $BOT | awk '{print $2}')
  REQS=$(echo $BOT | awk '{print $3}')
  
  echo "🔹 Подготавливаем $FOLDER…"
  mkdir -p ~/bots/$FOLDER/logs
  cd ~/bots/$FOLDER
  if [ ! -d "venv" ]; then
    python3 -m venv venv
  fi
  source venv/bin/activate
  pip install --upgrade pip >/dev/null 2>&1 || true
  if [ -f "$REQS" ]; then
    pip install -r "$REQS" >/dev/null 2>&1 || true
  fi
done

echo "🔹 Запускаем ботов…"
nohup ~/bots/fdt_bot/venv/bin/python ~/bots/fdt_bot/fdt_bot.py >> ~/bots/fdt_bot/logs/fdt.log 2>&1 &
nohup ~/bots/panic_bot/venv/bin/python ~/bots/panic_bot/panic_bot.py >> ~/bots/panic_bot/logs/panic.log 2>&1 &
nohup ~/bots/price_bot/venv/bin/python ~/bots/price_bot/price_bot.py >> ~/bots/price_bot/logs/price.log 2>&1 &
nohup ~/bots/net_panic_bot/venv/bin/python ~/bots/net_panic_bot/bot.py >> ~/bots/net_panic_bot/logs/bot.log 2>&1 &

echo "✅ Все 4 бота запущены! Логи пишутся в ~/bots/*/logs/"
