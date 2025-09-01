import telebot
from telebot import types

# 🔹 Токен нового бота
TOKEN = "8433614169:AAH5b5hE-OkEfv0qf8OYz-FwbWkYHPlER5c"
bot = telebot.TeleBot(TOKEN)

# Правила с текстом и фото
rules = {
    "Правила 1-5": {
        "1️⃣ Наладь питание для нервов": "https://mensby.com/wp-content/uploads/2021/01/zheleznye-nervy-15-sposobov-obresti-stalnye-nervy-03.jpg",
        "2️⃣ Не бойся поражений": "https://mensby.com/wp-content/uploads/2021/01/zheleznye-nervy-15-sposobov-obresti-stalnye-nervy-04.jpg",
        "3️⃣ Займись спортом для выдержки": "https://via.placeholder.com/800x600.png?text=Sport+Activity",
        "4️⃣ Не сопротивляйся переменам": "https://via.placeholder.com/800x600.png?text=Change",
        "5️⃣ Начни высыпаться и отдыхать": "https://via.placeholder.com/800x600.png?text=Sleep+Well"
    },
    "Правила 6-10": {
        "6️⃣ Находи время на себя": "https://via.placeholder.com/800x600.png?text=Me+Time",
        "7️⃣ Уделяй время отношениям": "https://mensby.com/wp-content/uploads/2021/01/zheleznye-nervy-15-sposobov-obresti-stalnye-nervy-04.jpg",
        "8️⃣ Выбирай эгоизм": "https://via.placeholder.com/800x600.png?text=Healthy+Egoism",
        "9️⃣ Откажись от лишней ответственности": "https://via.placeholder.com/800x600.png?text=No+Excess+Responsibility",
        "🔟 Относись к жизни с иронией": "https://via.placeholder.com/800x600.png?text=Irony+Life"
    },
    "Правила 11-15": {
        "1️⃣1️⃣ Откажись и снизь вредные привычки": "https://via.placeholder.com/800x600.png?text=Healthy+Habits",
        "1️⃣2️⃣ Не копи негатив и проблемы": "https://via.placeholder.com/800x600.png?text=Release+Negativity",
        "1️⃣3️⃣ Импровизируй и будь гибче": "https://via.placeholder.com/800x600.png?text=Be+Flexible",
        "1️⃣4️⃣ Оттягивайся и отдыхай": "https://via.placeholder.com/800x600.png?text=Relax+And+Have+Fun",
        "1️⃣5️⃣ Контакты": None  # тут будет текст, фото не нужно
    }
}

# Главное меню с подменю
def main_menu():
    kb = types.ReplyKeyboardMarkup(resize_keyboard=True)
    kb.add("Правила 1-5", "Правила 6-10", "Правила 11-15")
    return kb

# Меню для подгрупп правил
def sub_menu(group_name):
    kb = types.ReplyKeyboardMarkup(resize_keyboard=True)
    for key in rules[group_name]:
        kb.add(key)
    kb.add("⬅️ Главное меню")
    return kb

# Старт
@bot.message_handler(commands=['start'])
def start(message):
    bot.send_message(
        message.chat.id,
        "🛡️ Привет! Я бот *Железные нервы* v2.\n"
        "Здесь ты найдёшь 15 правил для стального хладнокровия.\n\n"
        "Выбирай пункт из меню ниже:",
        reply_markup=main_menu()
    )

# Обработка сообщений
@bot.message_handler(func=lambda m: True)
def handle(message):
    text = message.text.strip()

    # Главное меню
    if text in rules.keys():
        bot.send_message(message.chat.id, f"Выберите правило из группы {text}:", reply_markup=sub_menu(text))
        return

    # Подменю правил
    for group_name, group in rules.items():
        if text in group:
            if group[text]:
                bot.send_photo(message.chat.id, group[text], caption=text)
            else:
                bot.send_message(message.chat.id, "📞 Контакты для связи: @MSL72Rph")
            return

    # Возврат в главное меню
    if text == "⬅️ Главное меню":
        bot.send_message(message.chat.id, "Возвращаемся в главное меню:", reply_markup=main_menu())
        return

    # Любой другой ввод
    bot.send_message(message.chat.id, "Пожалуйста, выберите раздел из меню:", reply_markup=main_menu())

# Запуск
print("✅ Iron Nerves Bot v2 (подменю) запущен...")
bot.polling(none_stop=True)
