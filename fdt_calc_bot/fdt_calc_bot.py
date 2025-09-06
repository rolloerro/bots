# fdt_calc_bot.py
import telebot
from telebot import types
import math

# Токен (зашит прямо в код)
TOKEN = "8215850630:AAETWXW8P0_8McnXklulm6jtmKzTglJXwVg"
bot = telebot.TeleBot(TOKEN)

# --- Калькуляторы ---

def calc_skin(diameter, power_density=0.4, dose=300):
    """Калькулятор для кожи, шейки, влагалища, вульвы"""
    radius = diameter / 2
    area = math.pi * (radius ** 2)
    power_mw = power_density * area * 1000  # мВт
    total_dose = dose * area
    exposure = total_dose / (power_density * area * 1000) / 60  # мин
    return f"""📊 Расчёт ФДТ (Кожа/Шейка/Влагалище/Вульва)

Диаметр излучения: {diameter} см
Радиус: {radius:.2f} см
Площадь: {area:.2f} см²

Плотность мощности: {power_density} Вт/см²
Мощность излучателя: {power_mw:.0f} мВт

Доза облучения: {dose} Дж/см²
Общая доза: {total_dose:.0f} Дж

⏱ Экспозиция: {exposure:.2f} мин
"""

def calc_cervix(diffuser_length, power_mw, distance, dose=300):
    """Калькулятор для цервикального канала"""
    # Упрощённая модель: время растёт линейно с длиной диффузора
    base_time = 15.6 * diffuser_length / 4  # при 4 см = 15.6 мин
    return f"""👩‍⚕️ Расчёт ФДТ (Цервикальный канал)

Длина диффузора: {diffuser_length} см
Мощность излучателя: {power_mw} мВт
Расстояние до опухоли: {distance} см
Доза облучения: {dose} Дж/см²

⏱ Экспозиция: {base_time:.2f} мин
"""

def calc_urology(diffuser_length, power_mw, distance, dose=300):
    """Калькулятор для урологии и эндоскопии"""
    # Базовое время как в гинекологии
    base_time = 15.6 * diffuser_length / 4
    # Учитываем расстояние
    factor = 1 + (distance / 0.1) * 0.05
    exposure = base_time * factor
    return f"""🧑‍⚕️ Расчёт ФДТ (Урология и эндоскопия)

Длина диффузора: {diffuser_length} см
Мощность излучателя: {power_mw} мВт
Расстояние до опухоли: {distance} см
Доза облучения: {dose} Дж/см²

⏱ Экспозиция: {exposure:.2f} мин
"""

# --- Меню ---

def main_menu():
    markup = types.ReplyKeyboardMarkup(resize_keyboard=True)
    markup.row("🧴 Кожа/Шейка/Влагалище/Вульва")
    markup.row("👩‍⚕️ Цервикальный канал")
    markup.row("🧑‍⚕️ Урология и эндоскопия")
    return markup

@bot.message_handler(commands=['start'])
def start(message):
    bot.send_message(message.chat.id,
                     "Привет! 👋 Я FDT_CalcBot. Выберите калькулятор:",
                     reply_markup=main_menu())

@bot.message_handler(func=lambda message: message.text == "🧴 Кожа/Шейка/Влагалище/Вульва")
def skin_calc(message):
    bot.send_message(message.chat.id,
                     "Введите диаметр излучения в см (от 1 до 7):")
    bot.register_next_step_handler(message, process_skin)

def process_skin(message):
    try:
        diameter = float(message.text)
        result = calc_skin(diameter)
        bot.send_message(message.chat.id, result, reply_markup=main_menu())
    except:
        bot.send_message(message.chat.id, "Ошибка ввода. Введите число.")

@bot.message_handler(func=lambda message: message.text == "👩‍⚕️ Цервикальный канал")
def cervix_calc(message):
    bot.send_message(message.chat.id,
                     "Введите длину диффузора (2-6 см):")
    bot.register_next_step_handler(message, process_cervix_length)

def process_cervix_length(message):
    try:
        length = float(message.text)
        bot.send_message(message.chat.id, "Введите мощность излучателя (мВт, ≤1000):")
        bot.register_next_step_handler(message, process_cervix_power, length)
    except:
        bot.send_message(message.chat.id, "Ошибка ввода. Введите число.")

def process_cervix_power(message, length):
    try:
        power = float(message.text)
        bot.send_message(message.chat.id, "Введите расстояние до опухоли (см):")
        bot.register_next_step_handler(message, process_cervix_distance, length, power)
    except:
        bot.send_message(message.chat.id, "Ошибка ввода. Введите число.")

def process_cervix_distance(message, length, power):
    try:
        distance = float(message.text)
        result = calc_cervix(length, power, distance)
        bot.send_message(message.chat.id, result, reply_markup=main_menu())
    except:
        bot.send_message(message.chat.id, "Ошибка ввода. Введите число.")

@bot.message_handler(func=lambda message: message.text == "🧑‍⚕️ Урология и эндоскопия")
def uro_calc(message):
    bot.send_message(message.chat.id, "Введите длину диффузора (2-7 см):")
    bot.register_next_step_handler(message, process_uro_length)

def process_uro_length(message):
    try:
        length = float(message.text)
        bot.send_message(message.chat.id, "Введите мощность излучателя (мВт, ≤1000):")
        bot.register_next_step_handler(message, process_uro_power, length)
    except:
        bot.send_message(message.chat.id, "Ошибка ввода. Введите число.")

def process_uro_power(message, length):
    try:
        power = float(message.text)
        bot.send_message(message.chat.id, "Введите расстояние до опухоли (см):")
        bot.register_next_step_handler(message, process_uro_distance, length, power)
    except:
        bot.send_message(message.chat.id, "Ошибка ввода. Введите число.")

def process_uro_distance(message, length, power):
    try:
        distance = float(message.text)
        result = calc_urology(length, power, distance)
        bot.send_message(message.chat.id, result, reply_markup=main_menu())
    except:
        bot.send_message(message.chat.id, "Ошибка ввода. Введите число.")

# --- Запуск ---
if __name__ == "__main__":
    print("🚀 FDT_CalcBot запущен...")
    bot.infinity_polling()
