import telebot
from telebot import types

TOKEN = "8411928903:AAHvbnpukpJIXFVCUvu-pkJGwmDREwYRFko"
bot = telebot.TeleBot(TOKEN)

# Главное меню (классика, статично)
def main_menu():
    keyboard = types.ReplyKeyboardMarkup(resize_keyboard=True, row_width=2)
    buttons = [
        "🏥 ЛПУ (Госконтракты)",
        "🏢 Дистрибьюторы",
        "💉 Частные медцентры",
        "🎓 Обучение врачей ФДТ",
        "📞 Контакты"
    ]
    for b in buttons:
        keyboard.add(b)
    return keyboard

# Старт
@bot.message_handler(commands=['start'])
def send_welcome(message):
    bot.send_message(
        message.chat.id,
        "Здравствуйте! 👋 Выберите категорию, чтобы узнать цены на РадАхлорин или пройти обучение:",
        reply_markup=main_menu()
    )

# Ответы на кнопки
@bot.message_handler(func=lambda m: True)
def answer(message):
    text = message.text.strip()

    if text == "🏥 ЛПУ (Госконтракты)":
        bot.send_message(
            message.chat.id,
            "💊 **ЛПУ (Госконтракты) — цены на РадАхлорин:**\n\n"
            "🔹 Радахлорин 10мг — 19 500 ₽\n"
            "🔹 Радахлорин 15мг — 27 000 ₽",
            reply_markup=main_menu()
        )

    elif text == "🏢 Дистрибьюторы":
        bot.send_message(
            message.chat.id,
            "🏢 **Дистрибьюторы — цены на РадАхлорин:**\n\n"
            "🔹 Радахлорин 10мг — 15 900 ₽\n"
            "🔹 Радахлорин 15мг — 15 900 ₽",
            reply_markup=main_menu()
        )

    elif text == "💉 Частные медцентры":
        bot.send_message(
            message.chat.id,
            "💉 **Частные медцентры — цены на РадАхлорин:**\n\n"
            "🔹 Радахлорин 10мг — 16 300 ₽\n"
            "🔹 Радахлорин 15мг — 22 500 ₽",
            reply_markup=main_menu()
        )

    elif text == "🎓 Обучение врачей ФДТ":
        bot.send_message(
            message.chat.id,
            "🎓 **Обучение врачей онкологов на курсах ФДТ**\n\n"
            "✅ Практические занятия по фотодинамической терапии\n"
            "✅ Выдача сертификата по окончании курса\n\n"
            "Для записи и деталей обращайтесь: @MSL72Rph",
            reply_markup=main_menu()
        )

    elif text == "📞 Контакты":
        bot.send_message(
            message.chat.id,
            "📞 Для связи и консультации обращайтесь: @MSL72Rph",
            reply_markup=main_menu()
        )

    else:
        bot.send_message(
            message.chat.id,
            "Пожалуйста, выберите раздел из меню ниже:",
            reply_markup=main_menu()
        )

print("🤖 Price Bot запущен...")
bot.polling(none_stop=True)
