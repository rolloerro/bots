#!/bin/bash

# Имя сессии tmux
SESSION="bots"

# Папка с ботами
BASE_DIR="$HOME/bots/bots"

# Создаем сессию tmux, если её нет
tmux has-session -t $SESSION 2>/dev/null
if [ $? != 0 ]; then
    tmux new-session -d -s $SESSION
fi

# Активируем виртуальное окружение
source "$BASE_DIR/venv/bin/activate"

# Функция запуска бота в отдельном окне tmux с автоперезапуском
start_bot() {
    local bot_name=$1
    local bot_path=$2
    local log_dir=$3

    # Создаем папку logs, если нет
    mkdir -p "$log_dir"

    # Создаем новое окно для бота
    tmux new-window -t $SESSION -n "$bot_name"

    # Команда автоперезапуска через цикл while
    tmux send-keys -t $SESSION:"$bot_name" "
while true; do
    python3 $bot_path > $log_dir/bot.log 2>&1
    echo '⚠ $bot_name упал, перезапуск через 5 секунд...'
    sleep 5
done
" C-m
}

# Запуск всех ботов
start_bot "FDT_BOT_RF" "$BASE_DIR/FDT_BOT_RF/fdt_bot.py" "$BASE_DIR/FDT_BOT_RF/logs"
start_bot "Price_Bot" "$BASE_DIR/price_bot/price_bot.py" "$BASE_DIR/price_bot/logs"
start_bot "NET_Panic_Bot" "$BASE_DIR/net_panic_bot/net_panic_bot.py" "$BASE_DIR/net_panic_bot/logs"
start_bot "Panic_Bot" "$BASE_DIR/panitab_bot/panitab_bot.py" "$BASE_DIR/panitab_bot/logs"

# Подключаемся к сессии tmux
tmux attach -t $SESSION
