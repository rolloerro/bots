#!/bin/bash

# Убиваем старые процессы бота
pkill -f price_bot.py

# Переходим в папку с ботом
cd ~/bots/price_bot

# Активируем виртуальное окружение
source venv/bin/activate

# Запускаем бота
python3 price_bot.py




