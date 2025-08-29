import os
import sys
import subprocess
import venv

# Папка проекта
BOT_DIR = os.path.dirname(os.path.abspath(__file__))
VENV_DIR = os.path.join(BOT_DIR, "venv")

# Создаём виртуальное окружение, если его нет
if not os.path.exists(VENV_DIR):
    print("Создаём виртуальное окружение...")
    venv.create(VENV_DIR, with_pip=True)

# Путь к python внутри venv
PYTHON = os.path.join(VENV_DIR, "bin", "python")

# Устанавливаем зависимости
requirements_path = os.path.join(BOT_DIR, "requirements.txt")
if os.path.exists(requirements_path):
    print("Устанавливаем зависимости...")
    subprocess.check_call([PYTHON, "-m", "pip", "install", "-r", requirements_path])
else:
    print("Файл requirements.txt не найден. Пропускаем установку зависимостей.")

# Список ботов
bots = ["price_bot.py", "panic_bot.py"]

# Запуск ботов параллельно
processes = []
for bot in bots:
    bot_path = os.path.join(BOT_DIR, bot)
    if os.path.exists(bot_path):
        print(f"Запускаем {bot}...")
        p = subprocess.Popen([PYTHON, bot_path])
        processes.append(p)
    else:
        print(f"{bot} не найден!")

# Ожидание завершения (боты будут работать пока не остановишь)
for p in processes:
    p.wait()
