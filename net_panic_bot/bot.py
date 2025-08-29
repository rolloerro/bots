import logging
from telegram import Update, InlineKeyboardButton, InlineKeyboardMarkup
from telegram.ext import ApplicationBuilder, CommandHandler, CallbackQueryHandler, ContextTypes

TOKEN = "8247573717:AAEWVkxsTFsCzbPGIWwLkfQvcfpAdJromaU"

logging.basicConfig(
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
    level=logging.INFO,
)

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
        response = "⚡ 10 советов при панической атаке:\n1. Осознайте, что это паническая атака\n2. Не пытайтесь бороться\n3. Дышите глубоко\n4. Методы заземления\n5. Дайте мозгу задачу\n6. Визуализируйте счастье\n7. Поговорите с другом\n8. Определите безопасные места\n9. Думайте позитивно\n10. Расслабьте мышцы"
    elif query.data == 'techniques':
        response = "🔧 10 техник:\n" + "\n".join(TECHNIQUES)
    elif query.data == 'truth':
        response = "📘 Профилактика:\n• Спорт\n• Сон и питание\n• Йога и медитация\n• Ведение дневника"
    elif query.data == 'help':
        response = "ℹ️ Помощь: дышите глубоко, оставайтесь на месте, обратитесь к близким или психологу."
    elif query.data == 'plan':
        response = "📅 План на день: начинайте с малого, двигайтесь вперёд, фиксируйте успехи."
    elif query.data == 'reset':
        response = "🔄 Сброс: меню обновлено, выберите опцию заново."
    elif query.data == 'info':
        response = "📝 Я бот для поддержки при панических атаках."
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

