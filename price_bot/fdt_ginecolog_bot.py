# fdt_ginecolog_bot.py
import telebot
from telebot import types
import os
from dotenv import load_dotenv

# Загружаем токен из .env
load_dotenv()
TOKEN = os.getenv("8484459015:AAFJ3h3QRkjGcC4YTPadg4C8FPASU46lf5c")
bot = telebot.TeleBot(TOKEN)

# Контакты
CONTACTS = "Telegram: @MSL72Rph"

# Содержимое для нозологий
FULL_TEXT = {
    "Склерозирующий лихен": """Причины:
- Хроническое воспаление, генетическая предрасположенность, аутоиммунные процессы.

Симптомы:
- Интенсивный зуд, эрозии, рубцы, дискомфорт при интимной близости.

Диагностика:
- Визуальный осмотр, биопсия при необходимости.

Лечение:
- Фотодинамическая терапия (ФДТ) с Радахлорином как органосохраняющий метод, предотвращающий рецидивы.
""",
    "Лейкоплакия вульвы": """Причины:
- Дистрофические изменения кожи, хроническое воспаление, гормональные нарушения.

Симптомы:
- Зуд, раздражение, боли при мочеиспускании и интимной близости.

Диагностика:
- Вульвоскопия, биопсия, цитология.

Лечение:
- ФДТ с Радахлорином для устранения патологических участков, сохранения ткани и снижения онкологических рисков.
""",
    "Дисплазия вульвы": """Причины:
- Инфекция ВПЧ, хронические воспаления, метаплазия эпителия.

Симптомы:
- Часто бессимптомно, возможны зуд, эрозии, белые бляшки.

Диагностика:
- Вульвоскопия, биопсия, гистология.

Лечение:
- ФДТ с Радахлорином, щадящие методы абляции, наблюдение для предотвращения прогрессии к раку.
""",
    "Дисплазия шейки матки": """Причины:
- ВПЧ высокоонкогенных типов, хроническое воспаление, дисбиоз влагалища.

Симптомы:
- Обычно бессимптомно, выявляется на профилактических осмотрах, возможно нарушение цикла, выделения.

Диагностика:
- Цитология, ПЦР на ВПЧ, кольпоскопия, биопсия при необходимости.

Лечение:
- Легкая степень: наблюдение и ФДТ при показаниях.
- Высокая степень: ФДТ с Радахлорином при органосохраняющих вмешательствах, абляция, конизация при необходимости.
"""
}

COMPACT_TEXT = {
    "Склерозирующий лихен": "Зуд, эрозии, рубцы. ФДТ с Радахлорином — органосохраняющий метод.",
    "Лейкоплакия вульвы": "Зуд, раздражение, боли. ФДТ с Радахлорином снижает онко-риск.",
    "Дисплазия вульвы": "Часто бессимптомно. ФДТ с Радахлорином предотвращает прогрессию.",
    "Дисплазия шейки матки": "Выявляется на осмотре. ФДТ с Радахлорином помогает при легкой и средней степени."
}

RADACHLORIN_TEXT = """Радахлорин — уникальный, натуральный, безопасный фотосенсибилизатор. 
Используется в ФДТ для органосохраняющего лечения онкологических и предраковых состояний, 
а также в реабилитации после операций, химио- и лучевой терапии."""

# Главное меню
def main_menu_markup():
    markup = types.ReplyKeyboardMarkup(resize_keyboard=True)
    markup.row("Врач", "Пациент")
    return markup

def mode_menu_markup():
    markup = types.ReplyKeyboardMarkup(resize_keyboard=True)
    markup.row("Полный вариант", "Компактный вариант")
    return markup

def nosology_menu_markup():
    markup = types.ReplyKeyboardMarkup(resize_keyboard=True)
    markup.row("Склерозирующий лихен", "Лейкоплакия вульвы")
    markup.row("Дисплазия вульвы", "Дисплазия шейки матки")
    markup.row("Радахлорин", "Контакты", "Главное меню")
    return markup

# Обработчики
@bot.message_handler(commands=['start'])
def start(message):
    bot.send_message(message.chat.id,
                     "Привет! Выберите кто вы:", reply_markup=main_menu_markup())

@bot.message_handler(func=lambda message: message.text in ["Врач", "Пациент"])
def choose_mode(message):
    bot.send_message(message.chat.id,
                     "Выберите режим отображения информации:", reply_markup=mode_menu_markup())
    bot.register_next_step_handler(message, select_mode, message.text)

def select_mode(message, user_type):
    mode = message.text
    if mode not in ["Полный вариант", "Компактный вариант"]:
        bot.send_message(message.chat.id, "Выберите корректный режим.", reply_markup=mode_menu_markup())
        return
    bot.send_message(message.chat.id,
                     f"Вы выбрали {mode}. Теперь выберите нозологию:", reply_markup=nosology_menu_markup())
    bot.register_next_step_handler(message, show_nosology, mode)

def show_nosology(message, mode):
    text_dict = FULL_TEXT if mode == "Полный вариант" else COMPACT_TEXT
    text = ""
    if message.text in text_dict:
        text = text_dict[message.text]
    elif message.text == "Радахлорин":
        text = RADACHLORIN_TEXT
    elif message.text == "Контакты":
        text = CONTACTS
    elif message.text == "Главное меню":
        start(message)
        return
    else:
        text = "Выберите корректную опцию."
    bot.send_message(message.chat.id, text, reply_markup=nosology_menu_markup())

# Запуск бота
if __name__ == "__main__":
    print("Бот запущен...")
    bot.infinity_polling()
from dotenv import load_dotenv
import os
import telebot

load_dotenv()
TOKEN = os.getenv('BOT_TOKEN')
bot = telebot.TeleBot(TOKEN)

