#!/bin/bash

echo "🛑 Останавливаем все боты..."
pkill -f FDT_CalcBot.py
pkill -f fdt_bot.py
pkill -f price_bot.py
pkill -f fdt_ginecolog_bot.py
echo "✅ Все боты остановлены!"
