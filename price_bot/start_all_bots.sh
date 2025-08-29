#!/bin/bash
# Финальный скрипт запуска ботов на Mac
# Работает для FDT_BOT, NET_panic_bot и price_bot

BOT_DIR="$HOME/bots"

# Список ботов и их путей
FDT_BOT="$BOT_DIR/FDT_BOT/fdt_bot.py"
NET_PANIC_BOT="$BOT_DIR/NET_panic_bot/net_panic_bot.py"
PRICE_BOT="$BOT_DIR/price_bot/price_bot.py"

# Функция запуска бота с авто-перезапуском
run_bot() {
    BOT_PATH="$1"
    BOT_NAME="$2"
    LOG_FILE="$BOT_DIR/${BOT_NAME}.log"

    if [ -f "$BOT_PATH" ]; then
        echo "✅ Запуск $BOT_NAME..."
        nohup bash -c "while true; do python3 $BOT_PATH; echo '⚠️ $BOT_NAME упал, перезапуск через 5 секунд...'; sleep 5; done" > "$LOG_FILE" 2>&1 &
    else
        echo "⚠️ Файл $BOT_PATH не найден — нужно скопировать!"
    fi
}

echo "🔹 Останавливаем старые процессы Python..."
pkill -f python3

echo "🔹 Запускаем ботов..."
run_bot "$FDT_BOT" "FDT_BOT"
run_bot "$NET_PANIC_BOT" "NET_panic_bot"
run_bot "$PRICE_BOT" "price_bot"

echo "✅ Все доступные боты запущены. Логи: $BOT_DIR/*.log"
