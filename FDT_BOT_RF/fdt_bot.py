import telebot
from telebot import types
import os
import time

# 🔹 Токен бота
TOKEN = "8326999962:AAGHsm79Phu5njRrj1FmA4xHIJCv9uykSRc"
bot = telebot.TeleBot(TOKEN)

# 🔹 Путь к PDF (поставь свой файл на рабочий стол)
PDF_PATH = "/Users/vladimirkopylov/Desktop/001. Брошюра ФДТ постранично.pdf"

# Главное меню
def main_menu():
    keyboard = types.ReplyKeyboardMarkup(resize_keyboard=True)
    buttons = [
        "Что такое ФДТ",
        "Препарат Радахлорин",
        "Преимущества метода",
        "Этапы лечения",
        "Где применяется",
        "Скачать брошюру",
        "Контакты"
    ]
    for b in buttons:
        keyboard.add(b)
    return keyboard

# Старт
@bot.message_handler(commands=['start'])
def send_welcome(message):
    bot.send_message(
        message.chat.id,
        "Здравствуйте! 👋 Я бот ФДТ РФ.",
        reply_markup=main_menu()
    )

# Ответы на кнопки
@bot.message_handler(func=lambda m: True)
def answer(message):
    text = message.text.strip()

    if text == "Что такое ФДТ":
        bot.send_message(
            message.chat.id,
            "Фотодинамическая терапия (ФДТ) – это современный метод лечения, основанный на взаимодействии препарата и света определённой длины волны."
        )

    elif text == "Препарат Радахлорин":
        bot.send_message(
            message.chat.id,
            "«Радахлорин» – российский фотосенсибилизатор нового поколения, разработанный для применения в ФДТ."
        )

    elif text == "Преимущества метода":
        bot.send_message(
            message.chat.id,
            "ФДТ имеет множество преимуществ: высокая избирательность, минимальные побочные эффекты, амбулаторное лечение."
        )

    elif text == "Этапы лечения":
        bot.send_message(
            message.chat.id,
            "Этапы лечения: введение препарата, накопление, диагностика, световое воздействие. Всё проводится амбулаторно."
        )

    elif text == "Где применяется":
        bot.send_message(
            message.chat.id,
            "ФДТ применяется при опухолях кожи, слизистых, ЖКТ, гинекологии, урологии, стоматологии."
        )

    elif text == "Скачать брошюру":
        if os.path.exists(PDF_PATH):
            with open(PDF_PATH, "rb") as pdf:
                bot.send_document(message.chat.id, pdf, caption="📕 Полная брошюра по ФДТ")
        else:
            bot.send_message(message.chat.id, f"❗ Файл брошюры не найден по пути:\n{PDF_PATH}")

    elif text == "Контакты":
        bot.send_message(message.chat.id, "📞 Для консультации обращайтесь: @MSL72Rph")

    else:
        bot.send_message(message.chat.id, "Пожалуйста, выберите раздел из меню:", reply_markup=main_menu())

print("🤖 Бот запущен...")

while True:
    try:
        bot.polling(none_stop=True, interval=0, timeout=20)
    except Exception as e:
        print(f"⚠️ Ошибка: {e}")
        time.sleep(5)

    try:
        bot.polling(none_stop=True, interval=0, timeout=20)
    except Exception as e:
        print(f"⚠️ Ошибка: {e}")
        time.sleep(5)
