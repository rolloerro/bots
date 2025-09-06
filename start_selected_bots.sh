#!/bin/bash

# Пути к ботам
BOTS=("fdt_bot" "price_bot" "fdt_ginecolog_bot")

echo "🔹 Останавливаем старые процессы..."
for BOT in "${BOTS[@]}"; do
    pkill -f "${BOT}.py" 2>/dev/null
done

echo "🔹 Создаём папки logs, если их нет..."
for BOT in "${BOTS[@]}"; do
    mkdir -p ~/bots/"$BOT"/logs
done

echo "🔹 Запускаем выбранные боты..."
# FDT бот
cd ~/bots/fdt_bot && source venv/bin/activate && nohup python3 fdt_bot.py > logs/fdt_bot.log 2>&1 &
# Price бот
cd ~/bots/price_bot && source venv/bin/activate && nohup python3 price_bot.py > logs/price_bot.log 2>&1 &
# FDT гинеколог бот
cd ~/bots/fdt_ginecolog_bot && source venv/bin/activate && nohup python3 fdt_ginecolog_bot.py > logs/fdt_ginecolog_bot.log 2>&1 &

echo "✅ Выбранные боты запущены. Логи: ~/bots/*/logs/"
