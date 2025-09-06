#!/bin/bash

# Активируем виртуальное окружение
source ~/bots/bots/venv/bin/activate

# Пути к ботам
BASE_DIR=~/bots/bots

declare -A BOTS
BOTS["FDT_BOT_RF"]="$BASE_DIR/FDT_BOT_RF/fdt_bot.py"
BOTS["price_bot"]="$BASE_DIR/price_bot/price_bot.py"
BOTS["NET_panic_bot"]="$BASE_DIR/net_panic_bot/net_panic_bot.py"
BOTS["panictab_bot"]="$BASE_DIR/panictab_bot/panictab_bot.py"

# Функция запуска
start_bot() {
    local name=$1
    local path=$2
    local log_dir=$(dirname $path)/logs

    mkdir -p "$log_dir"
    nohup python3 "$path" > "$log_dir/bot.log" 2>&1 &
    echo "✅ $name запущен (лог: $log_dir/bot.log)"
}

# Останавливаем старые процессы
for bot_name in "${!BOTS[@]}"; do
    pkill -f "${BOTS[$bot_name]}"
done
sleep 1

# Запускаем всех ботов
for bot_name in "${!BOTS[@]}"; do
    start_bot "$bot_name" "${BOTS[$bot_name]}"
done

echo "🚀 Все доступные боты запущены!"
[201~201~#!/bin/bash

# Виртуальное окружение
VENV_DIR="$HOME/bots/bots/venv"
source "$VENV_DIR/bin/activate"

# Путь до директории с ботами
BASE_DIR="$HOME/bots/bots"

# Функция для запуска бота
start_bot() {
    BOT_NAME=$1
    BOT_FILE=$2
    LOG_DIR="$BASE_DIR/$BOT_NAME/logs"

    # Создаём папку для логов, если нет
    mkdir -p "$LOG_DIR"

    # Запускаем бота в фоне и пишем лог
    nohup python3 "$BASE_DIR/$BOT_NAME/$BOT_FILE" > "$LOG_DIR/bot.log" 2>&1 &
    echo "✅ $BOT_NAME запущен, лог: $LOG_DIR/bot.log"
}

# Запускаем всех ботов
start_bot "FDT_BOT_RF" "fdt_bot.py"
start_bot "price_bot" "price_bot.py"
start_bot "net_panic_bot" "net_panic_bot.py"
start_bot "panictab_bot" "panictab_bot.py"

echo "🚀 Все боты запущены!"
