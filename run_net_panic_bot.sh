#!/usr/bin/env bash
set -e

BASE_DIR="$HOME/bots/NET_panic_bot"
BOT_FILE="$BASE_DIR/bot.py"
LOG_DIR="$BASE_DIR/logs"
LOG_FILE="$LOG_DIR/bot.log"

TOKEN="8247573717:AAEWVkxsTFsCzbPGIWwLkfQvcfpAdJromaU"

# 1️⃣ Создаём папку бота и логов
mkdir -p "$BASE_DIR"
mkdir -p "$LOG_DIR"

# 2️⃣ Создаём виртуальное окружение, если его нет
VENV_DIR="$BASE_DIR/venv"
if [ ! -d "$VENV_DIR" ]; then
    python3 -m venv "$VENV_DIR"
    source "$VENV_DIR/bin/activate"
    pip install --upgrade pip
    pip install python-telegram-bot>=20.0 python-dotenv>=1.0
else
    source "$VENV_DIR/bin/activate"
fi

# 3️⃣ Создаём файл bot.py (если ещё нет)
if [ ! -f "$BOT_FILE" ]; then
cat > "$BOT_FILE" <<EOF
#!/usr/bin/env python3
import logging
from telegram import Update
from telegram.ext import ApplicationBuilder, CommandHandler, MessageHandler, ContextTypes, filters

TOKEN = "$TOKEN"

logging.basicConfig(
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
    level=logging.INFO,
)

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text("Привет! Я NET_panic_bot ⚡")

async def echo(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text(update.message.text)

def main():
    app = ApplicationBuilder().token(TOKEN).build()
    app.add_handler(CommandHandler("start", start))
    app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, echo))
    app.run_polling()

if __name__ == "__main__":
    main()
EOF
fi

# 4️⃣ Запускаем в фоне с авто-перезапуском
nohup bash -c "while true; do python3 $BOT_FILE || true; echo '⚠️ NET_panic_bot упал, перезапуск через 5 секунд...'; sleep 5; done" > "$LOG_FILE" 2>&1 &

echo "✅ NET_panic_bot запущен! Логи: $LOG_FILE"
