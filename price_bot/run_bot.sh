#!/bin/bash
source venv/bin/activate
echo "🚀 Запуск Price Bot..."
while true; do
    python3 price_bot.py
    echo "⚠️ Price Bot упал, перезапуск через 5 секунд..."
    sleep 5
done

