#!/usr/bin/env bash
set -e

BASE_DIR="$HOME/bots/NET_panic_bot"
BOT_FILE="$BASE_DIR/bot.py"
LOG_DIR="$BASE_DIR/logs"
LOG_FILE="$LOG_DIR/bot.log"
TOKEN="8247573717:AAEWVkxsTFsCzbPGIWwLkfQvcfpAdJromaU"

# Создаём папки
mkdir -p "$BASE_DIR"
mkdir -p "$LOG_DIR"

# Создаём виртуальное окружение
VENV_DIR="$BASE_DIR/venv"
if [ ! -d "$VENV_DIR" ]; then
    python3 -m venv "$VENV_DIR"
fi
source "$VENV_DIR/bin/activate"

# Устанавливаем зависимости
pip install --upgrade pip
pip install python-telegram-bot

# Создаём bot.py если его нет
if [ ! -f "$BOT_FILE" ]; then
cat > "$BOT_FILE" <<EOF
#!/usr/bin/env python3
import logging
from telegram import Update, InlineKeyboardButton, InlineKeyboardMarkup
from telegram.ext import ApplicationBuilder, CommandHandler, CallbackQueryHandler, ContextTypes

TOKEN = "$TOKEN"

logging.basicConfig(format="%(asctime)s - %(name)s - %(levelname)s - %(message)s", level=logging.INFO)

MAIN_MENU = [
    [InlineKeyboardButton("⚡ СРОЧНО ПАНИКА", callback_data='panic')],
    [InlineKeyboardButton("📘 ПРАВДА О ПА", callback_data='truth')],
    [InlineKeyboardButton("ℹ️ ПОМОЩЬ", callback_data='help')],
    [InlineKeyboardButton("🔧 10ТЕХНИК", callback_data='techniques')],
    [InlineKeyboardButton("📅 ПЛАН НА ДЕНЬ", callback_data='plan')],
    [InlineKeyboardButton("🔄 Сброс/старт", callback_data='reset')],
    [InlineKeyboardButton("📝 Информация", callback_data='info')],
]

TECHNIQUES = [
    "1. Глубокое дыхание",
    "2. Признание атаки",
    "3. Техника '54321'",
    "4. Мышечная релаксация",
    "5. Фокус на телесных ощущениях",
    "6. Визуализация",
    "7. Физическая активность",
    "8. Пересмотр мыслей",
    "9. Поиск поддержки",
    "10. Контроль над окружением"
]

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    reply_markup = InlineKeyboardMarkup(MAIN_MENU)
    await update.message.reply_text("Привет! Я NET_panic_bot. Выберите опцию:", reply_markup=reply_markup)

async def button(update: Update, context: ContextTypes.DEFAULT_TYPE):
    query = update.callback_query
    await query.answer()
    if query.data == 'panic':
        response = (
            "⚡ 10 советов, как справиться с панической атакой:\\n"
            "1. Осознайте, что это паническая атака\\n"
            "2. Не пытайтесь бороться\\n"
            "3. Используйте дыхательные техники\\n"
            "4. Попробуйте методы заземления\\n"
            "5. Дайте своему мозгу задачу\\n"
            "6. Визуализируйте счастье\\n"
            "7. Поговорите с другом\\n"
            "8. Определите безопасные места\\n"
            "9. Думайте позитивно\\n"
            "10. Расслабьте мышцы\\n"
            "📌 При частых приступах обратитесь к психологу."
        )
    elif query.data == 'techniques':
        response = "🔧 10 техник для борьбы с паническими атаками:\\n" + "\\n".join(TECHNIQUES)
    elif query.data == 'truth':
        response = (
            "📘 Профилактика и долгосрочная помощь:\\n"
            "• Регулярные занятия спортом\\n"
            "• Полноценный сон и здоровое питание\\n"
            "• Практики релаксации: йога и медитация\\n"
            "• Ведение дневника"
        )
    elif query.data == 'help':
        response = "ℹ️ Помощь: дышите глубоко, оставайтесь на месте, обратитесь к близким или психологу."
    elif query.data == 'plan':
        response = "📅 План на день: начните с малого, двигайтесь вперёд, фиксируйте успехи."
    elif query.data == 'reset':
        response = "🔄 Сброс: меню обновлено, выберите опцию заново."
    elif query.data == 'info':
        response = "📝 Информация: я бот для поддержки при панических атаках."
    else:
        response = "Неизвестная команда."

    reply_markup = InlineKeyboardMarkup(MAIN_MENU)
    await query.edit_message_text(text=response, reply_markup=reply_markup)

def main():
    app = ApplicationBuilder().token(TOKEN).build()
    app.add_handler(CommandHandler("start", start))
    app.add_handler(CallbackQueryHandler(button))
    print("✅ NET_panic_bot запущен!")
    app.run_polling()

if __name__ == "__main__":
    main()
EOF
fi

# Запускаем бот в фоне с перезапуском при падении
nohup bash -c "while true; do source $VENV_DIR/bin/activate && python3 $BOT_FILE || true; echo '⚠️ NET_panic_bot упал, перезапуск через 5 секунд...'; sleep 5; done" > "$LOG_FILE" 2>&1 &

echo "🚀 NET_panic_bot запущен! Логи: $LOG_FILE"
#!/bin/bash

BOT_DIR=~/bots/NET_panic_bot
LOG_DIR=$BOT_DIR/logs
LOG_FILE=$LOG_DIR/bot.log
VENV_DIR=$BOT_DIR/venv

mkdir -p $LOG_DIR

# Создаём виртуальное окружение, если его нет
if [ ! -d "$VENV_DIR" ]; then
    python3 -m venv $VENV_DIR
fi

# Активируем виртуальное окружение
source $VENV_DIR/bin/activate

# Обновляем pip и ставим зависимости
pip install --upgrade pip
pip install python-telegram-bot --quiet

BOT_FILE=$BOT_DIR/net_panic_bot.py

if [ ! -f "$BOT_FILE" ]; then
    echo "❌ Файл $BOT_FILE не найден!"
    exit 1
fi

# Запуск бота в фоне с логами
nohup python3 $BOT_FILE > $LOG_FILE 2>&1 &

echo "✅ NET_panic_bot запущен! Логи: $LOG_FILE"
#!/usr/bin/env python3
import logging
from telegram import Update, InlineKeyboardButton, InlineKeyboardMarkup
from telegram.ext import ApplicationBuilder, CommandHandler, CallbackQueryHandler, ContextTypes

TOKEN = "8247573717:AAEWVkxsTFsCzbPGIWwLkfQvcfpAdJromaU"

logging.basicConfig(
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
    level=logging.INFO,
)

# --- Данные для кнопок ---
MAIN_MENU = [
    ("⚡ СРОЧНО ПАНИКА", "panic"),
    ("📖 ПРАВДА О ПА", "truth"),
    ("🆘 ПОМОЩЬ", "help"),
    ("🔟 10 ТЕХНИК", "techniques"),
    ("📅 ПЛАН НА ДЕНЬ", "plan"),
    ("🔄 Сброс/старт", "reset"),
    ("ℹ️ ИНФО", "info"),
    ("💬 Контакты", "contacts")
]

# --- Информация ---
INFO_TEXT = (
    "Мы собрали для вас наиболее действенные способы, которые можно использовать самостоятельно, "
    "чтобы остановить паническую атаку, даже если рядом нет врача:\n\n"
    "1️⃣ Глубоко и медленно дышите.\n"
    "2️⃣ Задержите дыхание на секунду.\n"
    "3️⃣ Признайте паническую атаку.\n"
    "4️⃣ Не отвлекайтесь, закройте глаза.\n"
    "5️⃣ Контролируйте сознание.\n"
    "6️⃣ Найдите объект фокусировки.\n"
    "7️⃣ Расслабьте мышцы.\n"
    "8️⃣ Представьте ресурсное место.\n"
    "9️⃣ Прогуляйтесь на свежем воздухе.\n"
    "🔟 Лаванда для успокоения.\n"
)

TECHNIQUES_TEXT = (
    "10 техник для борьбы с паникой:\n"
    "1. Глубокое дыхание\n"
    "2. Признание атаки\n"
    "3. Техника 54321\n"
    "4. Мышечная релаксация\n"
    "5. Фокусировка на телесных ощущениях\n"
    "6. Визуализация безопасного места\n"
    "7. Лёгкая физическая активность\n"
    "8. Пересмотр мыслей\n"
    "9. Поиск поддержки\n"
    "10. Контроль над окружением\n"
)

CONTACTS_TEXT = "Связаться с нами: @MSL72Rph (Pharm + OpenAI)"

# --- Функции ---
async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text(
        "Привет! Я NET_panic_bot ⚡\nВыберите пункт меню ниже:",
        reply_markup=main_keyboard()
    )

def main_keyboard():
    # Разбиваем на 4+4
    buttons = [InlineKeyboardButton(text, callback_data=data) for text, data in MAIN_MENU]
    return InlineKeyboardMarkup([buttons[:4], buttons[4:]])

async def button_handler(update: Update, context: ContextTypes.DEFAULT_TYPE):
    query = update.callback_query
    await query.answer()
    
    data = query.data
    if data == "panic":
        text = "🚨 Если паника началась: дышите глубоко, заземляйтесь, контролируйте мысли."
    elif data == "truth":
        text = "📖 Панические атаки не опасны физически, но требуют внимания к психике."
    elif data == "help":
        text = "🆘 Используйте техники релаксации, дыхание, заземление, поддержку близких."
    elif data == "techniques":
        text = TECHNIQUES_TEXT
    elif data == "plan":
        text = "📅 План на день: дыхательные упражнения утром, прогулки, позитивные практики."
    elif data == "reset":
        text = "🔄 Сброс меню. Начните сначала."
    elif data == "info":
        text = INFO_TEXT
    elif data == "contacts":
        text = CONTACTS_TEXT
    else:
        text = "❓ Неизвестная команда."
    
    await query.edit_message_text(text=text, reply_markup=main_keyboard())

# --- Основная функция ---
def main():
    app = ApplicationBuilder().token(TOKEN).build()
    app.add_handler(CommandHandler("start", start))
    app.add_handler(CallbackQueryHandler(button_handler))
    
    logging.info("Запуск NET_panic_bot...")
    app.run_polling()

if __name__ == "__main__":
    main()
