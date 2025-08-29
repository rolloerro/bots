#!/usr/bin/env python3
import time
import telebot
from telebot import types

# === Токен Telegram ===
TOKEN = "8247573717:AAEWVkxsTFsCzbPGIWwLkfQvcfpAdJromaU"
bot = telebot.TeleBot(TOKEN, parse_mode="HTML")

# === 10 техник ===
TECHNIQUES = [
    ("1. Дышите медленно", "Медленное дыхание 1-5, пауза 1, выдох 1-5. 1–3 минуты."),
    ("2. Признайте паническую атаку", "Скажите себе: «Это паническая атака, не опасно»."),
    ("3. Закройте глаза", "Снизьте стимулы: закройте глаза, 3 цикла дыхания."),
    ("4. Осознанность 5-4-3-2-1", "5 вижу, 4 касаюсь, 3 слышу, 2 запаха, 1 вкус."),
    ("5. Найдите «якорь»", "Сосредоточьтесь на одном предмете."),
    ("6. Мышечная релаксация", "Расслабляйте группы мышц по очереди."),
    ("7. Мысленное спокойное место", "Представьте место, где вам хорошо, 1–2 минуты."),
    ("8. Мягкая физическая активность", "Пройдитесь 3–5 минут, лёгкая разминка."),
    ("9. Обоняние", "Приятный запах усиливает успокоение."),
    ("10. Ритмичный текст", "Повторяйте текст в ритме дыхания."),
]

# === Главное меню ===
def main_menu():
    kb = types.ReplyKeyboardMarkup(resize_keyboard=True, row_width=2)
    kb.add(
        types.KeyboardButton("⚡ Срочно — паника"),
        types.KeyboardButton("🧰 10 техник"),
        types.KeyboardButton("ℹ️ Правда о ПА"),
        types.KeyboardButton("📋 План на день"),
        types.KeyboardButton("👨‍⚕️ Помощь"),
        types.KeyboardButton("🔁 Сброс/Старт")
    )
    return kb

WELCOME = (
    "🛡️ <b>НЕТ панике!</b>\n\n"
    "Самое важное: <b>от панических атак не умирают</b>.\n"
    "Выберите раздел ниже."
)

# === Обработчики сообщений ===
@bot.message_handler(commands=["start"])
def on_start(message):
    bot.send_message(message.chat.id, WELCOME, reply_markup=main_menu())

@bot.message_handler(func=lambda m: m.text == "🔁 Сброс/Старт")
def on_reset(message):
    on_start(message)

# === Срочно — паника ===
URGENT = (
    "⚡ <b>Быстрый протокол при панике</b>\n\n"
    "1) Напоминание: <b>от ПА не умирают</b>\n"
    "2) Дыхание 4-1-5: вдох 1-2-3-4 • пауза 1 • выдох 1-2-3-4-5 (60–120 сек)\n"
    "3) Заземление 5-4-3-2-1: 5 вижу • 4 касаюсь • 3 слышу • 2 запаха • 1 вкус\n"
    "4) Скажите: «Прилив пройдёт. Я в безопасности. Я управляю дыханием»\n\n"
    "Стало легче?"
)

def relief_kb():
    kb = types.ReplyKeyboardMarkup(resize_keyboard=True, row_width=3)
    kb.add(
        types.KeyboardButton("✅ Да"),
        types.KeyboardButton("➖ Немного"),
        types.KeyboardButton("❌ Пока нет")
    )
    kb.add(types.KeyboardButton("🔁 Сброс/Старт"))
    return kb

@bot.message_handler(func=lambda m: m.text == "⚡ Срочно — паника")
def on_panic(message):
    bot.send_message(message.chat.id, URGENT, reply_markup=relief_kb())

@bot.message_handler(func=lambda m: m.text in ["✅ Да", "➖ Немного", "❌ Пока нет"])
def on_relief_answer(message):
    if message.text == "✅ Да":
        bot.send_message(message.chat.id, "Отлично! Продолжайте дыхание и фокус ещё минуту.", reply_markup=main_menu())
    elif message.text == "➖ Немного":
        bot.send_message(message.chat.id, "Повторим дыхание 4-1-5 и заземление 5-4-3-2-1 ещё минуту.", reply_markup=relief_kb())
    else:
        bot.send_message(message.chat.id, "Я с вами. Ещё минута дыхания, затем нажмите «🧰 10 техник».", reply_markup=main_menu())

# === 10 техник: меню и callback ===
def techniques_menu():
    mk = types.InlineKeyboardMarkup(row_width=2)
    buttons = [types.InlineKeyboardButton(title, callback_data=f"tech_{i}") for i, (title, _) in enumerate(TECHNIQUES, start=1)]
    mk.add(*buttons)
    mk.add(types.InlineKeyboardButton("⬅️ Назад", callback_data="back_main"))
    return mk

@bot.message_handler(func=lambda m: m.text == "🧰 10 техник")
def on_tech_list(message):
    bot.send_message(message.chat.id, "Выберите технику:", reply_markup=techniques_menu())

@bot.callback_query_handler(func=lambda c: c.data.startswith("tech_") or c.data=="back_main")
def on_tech_click(call):
    if call.data == "back_main":
        bot.edit_message_text("Главное меню открыто 👇", call.message.chat.id, call.message.message_id)
        bot.send_message(call.message.chat.id, "Выберите раздел:", reply_markup=main_menu())
        return
    idx = int(call.data.split("_")[1]) - 1
    title, text = TECHNIQUES[idx]
    bot.answer_callback_query(call.id)
    bot.edit_message_text(f"<b>{title}</b>\n\n{text}", call.message.chat.id, call.message.message_id, parse_mode="HTML", reply_markup=techniques_menu())

# === Правда о ПА ===
TRUTH = (
    "ℹ️ <b>Правда о панических атаках</b>\n\n"
    "• ПА — безопасный, но неприятный стресс-отклик. От неё не умирают.\n"
    "• Пик обычно проходит за 5–10 минут.\n"
    "• Симптомы усиливаются страхом: спокойное дыхание и внимание ускоряют спад.\n"
    "• Помогают: дыхание, заземление, мягкая активность, корректный сон."
)
@bot.message_handler(func=lambda m: m.text == "ℹ️ Правда о ПА")
def on_truth(message):
    bot.send_message(message.chat.id, TRUTH)

# === План на день ===
PLAN = (
    "📋 <b>План на день</b>\n\n"
    "• Сон 7–9 часов, кофеин до обеда.\n"
    "• 10–20 мин. прогулки или лёгкая тренировка.\n"
    "• 2–3 цикла дыхания/осознанности по 2 мин.\n"
    "• Маленькие цели + короткие перерывы.\n"
    "• Вечером — тёплый душ, гаджеты ≤ 1 час до сна."
)
@bot.message_handler(func=lambda m: m.text == "📋 План на день")
def on_plan(message):
    bot.send_message(message.chat.id, PLAN)

# === Помощь с контактом ===
HELP = "👨‍⚕️ Если нужна помощь: @MSL72Rph"
@bot.message_handler(func=lambda m: m.text == "👨‍⚕️ Помощь")
def on_help(message):
    bot.send_message(message.chat.id, HELP)

# === Фолбэк ===
@bot.message_handler(func=lambda m: True)
def fallback(message):
    bot.send_message(message.chat.id, "Выберите раздел ниже 👇", reply_markup=main_menu())

print("🤖 NET PANIC Bot запущен…")

# === Автоперезапуск внутри Python ===
while True:
    try:
        bot.polling(none_stop=True, interval=0, timeout=30)
    except Exception as e:
        print("❌ Ошибка бота:", e)
        time.sleep(5)
