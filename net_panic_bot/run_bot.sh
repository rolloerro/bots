#!/bin/bash
# =========================
# Безопасный автозапуск NET_panic_bot
# =========================

BOT_NAME="bot.py"         # главный файл бота
VENV_PATH="./venv/bin/activate"

# Проверяем, есть ли старые процессы бота
OLD_PIDS=$(pgrep -f "$BOT_NAME")
if [ -n "$OLD_PIDS" ]; then
    echo "⚠️ Найдены старые процессы бота, убиваем их: $OLD_PIDS"
    kill -9 $OLD_PIDS
fi

# Активируем виртуальное окружение
source $VENV_PATH

# Запуск бота в бесконечном цикле
echo "🚀 Запускаем $BOT_NAME..."
while true; do
    python3 $BOT_NAME
    EXIT_CODE=$?
    echo "⚠️ $BOT_NAME завершился с кодом $EXIT_CODE. Перезапуск через 5 секунд..."
    sleep 5
done
