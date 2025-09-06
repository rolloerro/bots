#!/bin/bash
echo "🔹 Останавливаем старые процессы витринных ботов..."

pkill -f panic_bot.py
pkill -f net_panic_bot.py
pkill -f iron_nerves_bot.py

echo "🔹 Активируем виртуальное окружение..."
source ~/bots/venv/bin/activate

echo "🔹 Запускаем PanicBot..."
nohup python3 ~/bots/panic_bot/panic_bot.py > ~/bots/panic_bot/logs/panic_bot.log 2>&1 &

echo "🔹 Запускаем NetPanicBot..."
nohup python3 ~/bots/net_panic_bot/net_panic_bot.py > ~/bots/net_panic_bot/logs/net_panic_bot.log 2>&1 &

echo "🔹 Запускаем IronNervesBot..."
nohup python3 ~/bots/iron_nerves_bot/iron_nerves_bot.py > ~/bots/iron_nerves_bot/logs/iron_nerves_bot.log 2>&1 &

echo "✅ Все витринные боты запущены. Логи: ~/bots/*/logs/"
