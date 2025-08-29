#!/bin/bash

# Активируем виртуальное окружение
source venv/bin/activate

# Переходим в папки с ботами и запускаем их
echo "Запуск Price Bot..."
python3 price_bot/price_bot.py &

echo "Запуск Panic Bot..."
python3 panic_bot/net_panic_bot.py &

echo "Запуск FDT Bot..."
python3 fdt_bot/fdt_bot.py &

echo "Все боты запущены. Логи выводятся в терминал."

# Ждем завершения всех процессов (optional)
wait
