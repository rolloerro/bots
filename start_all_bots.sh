#!/bin/bash

BOT_DIR="$HOME/bots"

# Список ботов
BOT_NAMES=("FDT_BOT" "panictab_bot" "NET_panic_bot" "price_bot")
BOT_FILES=("FDT_BOT/fdt_bot.py" "panictab_bot/panictab_bot.py" "NET_panic_bot/net_panic_bot.py" "price_bot/price_bot.py")

echo "🔹 Останавливаем старые процессы..."
pkill -f "python3 $BOT_DIR" 2>/dev/null

echo "🔹 Запускаем ботов..."
for i in "${!BOT_NAMES[@]}"; do
    BOT_NAME="${BOT_NAMES[$i]}"
    BOT_PATH="$BOT_DIR/${BOT_FILES[$i]}"
    LOG_FILE="$BOT_DIR/${BOT_NAME}.log"

    if [ -f "$BOT_PATH" ]; then
        echo "✅ Запуск $BOT_NAME..."
        nohup bash -c "while true; do python3 $BOT_PATH; echo '⚠️ $BOT_NAME упал, перезапуск через 5 секунд...'; sleep 5; done" > "$LOG_FILE" 2>&1 &
    else
        echo "⚠️ Файл $BOT_PATH не найден!"
    fi
done

echo "✅ Все боты запущены. Логи: $BOT_DIR/*.log"
#!/bin/bash

BOT_DIR="$HOME/bots"

# Список ботов
BOT_NAMES=("FDT_BOT" "panictab_bot" "NET_panic_bot" "price_bot")
BOT_FILES=("FDT_BOT/fdt_bot.py" "panictab_bot/panictab_bot.py" "NET_panic_bot/net_panic_bot.py" "price_bot/price_bot.py")

echo "🔹 Останавливаем старые процессы..."
pkill -f "python3 $BOT_DIR" 2>/dev/null

echo "🔹 Запускаем ботов..."
for i in "${!BOT_NAMES[@]}"; do
    BOT_NAME="${BOT_NAMES[$i]}"
    BOT_PATH="$BOT_DIR/${BOT_FILES[$i]}"
    LOG_FILE="$BOT_DIR/${BOT_NAME}.log"

    if [ -f "$BOT_PATH" ]; then
        echo "✅ Запуск $BOT_NAME..."
        nohup bash -c "while true; do python3 $BOT_PATH; echo '⚠️ $BOT_NAME упал, перезапуск через 5 секунд...'; sleep 5; done" > "$LOG_FILE" 2>&1 &
    else
        echo "⚠️ Файл $BOT_PATH не найден!"
    fi
done

echo "✅ Все боты запущены. Логи: $BOT_DIR/*.log"

#!/bin/bash

BOT_DIR="$HOME/bots"
declare -A BOTS
BOTS["FDT_BOT"]="FDT_BOT/fdt_bot.py"
BOTS["panictab_bot"]="panictab_bot/panictab_bot.py"
BOTS["NET_panic_bot"]="NET_panic_bot/net_panic_bot.py"
BOTS["price_bot"]="price_bot/price_bot.py"

echo "🔹 Останавливаем старые процессы..."
pkill -f "python3 $BOT_DIR" 2>/dev/null

echo "🔹 Запускаем ботов..."
for BOT_NAME in "${!BOTS[@]}"; do
    BOT_PATH="$BOT_DIR/${BOTS[$BOT_NAME]}"
    LOG_FILE="$BOT_DIR/${BOT_NAME}.log"

    if [ -f "$BOT_PATH" ]; then
        echo "✅ Запуск $BOT_NAME..."
        nohup bash -c "while true; do python3 $BOT_PATH; echo '⚠️ $BOT_NAME упал, перезапуск через 5 секунд...'; sleep 5; done" > "$LOG_FILE" 2>&1 &
    else
        echo "⚠️ Файл $BOT_PATH не найден!"
    fi
done

echo "✅ Все боты запущены. Логи: $BOT_DIR/*.log"
#!/bin/bash
BOT_DIR="$HOME/bots"
declare -A BOTS
BOTS["FDT_BOT"]="FDT_BOT/fdt_bot.py"
BOTS["panictab_bot"]="panictab_bot/panictab_bot.py"
BOTS["NET_panic_bot"]="NET_panic_bot/net_panic_bot.py"
BOTS["price_bot"]="price_bot/price_bot.py"
echo "🔹 Останавливаем старые процессы..."
pkill -f "python3 $BOT_DIR" 2>/dev/null
echo "🔹 Запускаем ботов..."
for BOT_NAME in "\${!BOTS[@]}"; do
    BOT_PATH="\$BOT_DIR/\${BOTS[\$BOT_NAME]}"
    LOG_FILE="\$BOT_DIR/\${BOT_NAME}.log"
    if [ -f "\$BOT_PATH" ]; then
        echo "✅ Запуск \$BOT_NAME..."
        nohup bash -c "while true; do python3 \$BOT_PATH; echo '⚠️ \$BOT_NAME упал, перезапуск через 5 секунд...'; sleep 5; done" > "\$LOG_FILE" 2>&1 &
    else
        echo "⚠️ Файл \$BOT_PATH не найден!"
    fi
done
echo "✅ Все боты запущены. Логи: $BOT_DIR/*.log"
#!/bin/bash

BOT_DIR="$HOME/bots"
declare -A BOTS
BOTS["FDT_BOT"]="FDT_BOT/fdt_bot.py"
BOTS["panictab_bot"]="panictab_bot/panictab_bot.py"
BOTS["NET_panic_bot"]="NET_panic_bot/net_panic_bot.py"
BOTS["price_bot"]="price_bot/price_bot.py"

echo "🔹 Останавливаем старые процессы..."
pkill -f "python3 $BOT_DIR" 2>/dev/null

echo "🔹 Запускаем ботов..."
for BOT_NAME in "${!BOTS[@]}"; do
    BOT_PATH="$BOT_DIR/${BOTS[$BOT_NAME]}"
    LOG_FILE="$BOT_DIR/${BOT_NAME}.log"

    if [ -f "$BOT_PATH" ]; then
        echo "✅ Запуск $BOT_NAME..."
        nohup bash -c "while true; do python3 $BOT_PATH; echo '⚠️ $BOT_NAME упал, перезапуск через 5 секунд...'; sleep 5; done" > "$LOG_FILE" 2>&1 &
    else
        echo "⚠️ Файл $BOT_PATH не найден!"
    fi
done

echo "✅ Все боты запущены. Логи: $BOT_DIR/*.log"
#!/bin/bash

echo "🔹 Останавливаем старые процессы..."
pkill -f fdt_bot_rf.py
pkill -f panictab_bot.py
pkill -f net_panic_bot.py
pkill -f price_bot.py

echo "🔹 Запускаем ботов..."
nohup python3 ~/bots/FDT_BOT_RF/fdt_bot_rf.py > ~/bots/FDT_BOT_RF/logs/bot.log 2>&1 &
nohup python3 ~/bots/panictab_bot/panictab_bot.py > ~/bots/panictab_bot/logs/bot.log 2>&1 &
nohup python3 ~/bots/net_panic_bot/net_panic_bot.py > ~/bots/net_panic_bot/logs/bot.log 2>&1 &
nohup python3 ~/bots/price_bot/price_bot.py > ~/bots/price_bot/logs/bot.log 2>&1 &

echo "✅ Все боты запущены. Логи лежат в папках /logs"

#!/bin/bash

# === Список ботов ===
BOTS=(
  "FDT_BOT_RF:fdt_bot_rf.py"
  "panictab_bot:panictab_bot.py"
  "net_panic_bot:net_panic_bot.py"
  "price_bot:price_bot.py"
)

BASE_DIR=~/bots

echo "🔹 Останавливаем старые процессы..."
for BOT in "${BOTS[@]}"; do
  NAME="${BOT%%:*}"
  pkill -f "${NAME}" >/dev/null 2>&1
done

echo "🔹 Запускаем ботов..."
for BOT in "${BOTS[@]}"; do
  NAME="${BOT%%:*}"
  FILE="${BOT##*:}"
  DIR="$BASE_DIR/$NAME"
  LOG_DIR="$DIR/logs"
  LOG_FILE="$LOG_DIR/bot.log"

  # Проверяем, есть ли папка и файл бота
  if [[ ! -f "$DIR/$FILE" ]]; then
    echo "❌ $NAME — файл $FILE не найден!"
    continue
  fi

  # Создаём папку для логов
  mkdir -p "$LOG_DIR"

  # Запускаем с авто-перезапуском
  nohup bash -c "while true; do python3 $DIR/$FILE; \
  echo '⚠️ $NAME упал, перезапуск через 5 секунд...'; sleep 5; done" \
  > "$LOG_FILE" 2>&1 &

  echo "✅ $NAME запущен (логи: $LOG_FILE)"
done

echo "🚀 Все доступные боты ожили!"
echo "🚀 Все боты запущены. Логи смотри в папке logs."
echo "📂 Открываю VS Code..."
code ~/bots
#!/bin/bash
# 🚀 Скрипт для запуска всех ботов

BOTS_DIR=~/bots
LOGS_DIR=$BOTS_DIR/logs

# создаём папку для логов, если её нет
mkdir -p $LOGS_DIR

echo "🛑 Останавливаю старые процессы..."
pkill -f "python3 $BOTS_DIR" || true

echo "🔹 Запускаю ботов..."

# === FDT Bot ===
nohup python3 $BOTS_DIR/FDT_BOT_RF/fdt_bot.py > $LOGS_DIR/fdt_bot.log 2>&1 &
echo "✅ FDT_BOT запущен (лог: $LOGS_DIR/fdt_bot.log)"

# === PanicTab Bot ===
nohup python3 $BOTS_DIR/panitab_bot/panitab_bot.py > $LOGS_DIR/panitab_bot.log 2>&1 &
echo "✅ PANITAB_BOT запущен (лог: $LOGS_DIR/panitab_bot.log)"

# === NET Panic Bot ===
nohup python3 $BOTS_DIR/net_panic_bot/net_panic_bot.py > $LOGS_DIR/net_panic_bot.log 2>&1 &
echo "✅ NET_PANIC_BOT запущен (лог: $LOGS_DIR/net_panic_bot.log)"

# === Price Bot ===
nohup python3 $BOTS_DIR/price_bot/price_bot.py > $LOGS_DIR/price_bot.log 2>&1 &
echo "✅ PRICE_BOT запущен (лог: $LOGS_DIR/price_bot.log)"

echo "🚀 Все боты запущены. Логи: $LOGS_DIR"
echo "📂 Открываю VS Code..."

# Открываем папку в VS Code
code $BOTS_DIR


#!/bin/bash
echo "🔹 Останавливаем старые процессы..."
pkill -f fdt_bot.py
pkill -f price_bot.py

echo "🔹 Запускаем ботов..."
cd ~/bots/fdt_bot && source venv/bin/activate && nohup python3 fdt_bot.py > logs/fdt_bot.log 2>&1 &
cd ~/bots/price_bot && source venv/bin/activate && nohup python3 price_bot.py > logs/price_bot.log 2>&1 &

echo "✅ Все боты запущены. Логи: ~/bots/*/logs/"
#!/bin/bash

echo "🔹 Останавливаем старые процессы..."
pkill -f FDT_CalcBot.py
pkill -f fdt_bot.py
pkill -f price_bot.py
pkill -f fdt_ginecolog_bot.py

echo "🔹 Активируем виртуальное окружение..."
source ~/bots/FDT_CalcBot/venv/bin/activate

mkdir -p ~/bots/FDT_CalcBot/logs
mkdir -p ~/bots/fdt_bot/logs
mkdir -p ~/bots/price_bot/logs
mkdir -p ~/bots/fdt_ginecolog_bot/logs

echo "🔹 Запускаем ботов..."

nohup python3 ~/bots/FDT_CalcBot/FDT_CalcBot.py > ~/bots/FDT_CalcBot/logs/FDT_CalcBot.log 2>&1 &
echo "✅ Запуск FDT_CalcBot..."

nohup python3 ~/bots/fdt_bot/fdt_bot.py > ~/bots/fdt_bot/logs/fdt_bot.log 2>&1 &
echo "✅ Запуск fdt_bot..."

nohup python3 ~/bots/price_bot/price_bot.py > ~/bots/price_bot/logs/price_bot.log 2>&1 &
echo "✅ Запуск price_bot..."

nohup python3 ~/bots/fdt_ginecolog_bot/fdt_ginecolog_bot.py > ~/bots/fdt_ginecolog_bot/logs/fdt_ginecolog_bot.log 2>&1 &
echo "✅ Запуск fdt_ginecolog_bot..."

echo "🚀 Все боты запущены! Логи смотри в папках logs/"
