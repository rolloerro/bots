import rumps
import subprocess

# 🔹 Словарь ботов: ключ — название, значение — путь к скрипту
BOTS = {
    "FDT Bot": "~/bots/FDT_BOT_RF/fdt_bot.py",
    "Price Bot": "~/bots/price_bot/price_bot.py",
    "NET Panic Bot": "~/bots/net_panic_bot/net_panic_bot.py",
    "Panic Bot": "~/bots/panitab_bot/panitab_bot.py"
}

# Проверка, запущен ли бот
def is_running(bot_path):
    try:
        output = subprocess.check_output(["pgrep", "-f", bot_path])
        return bool(output.strip())
    except subprocess.CalledProcessError:
        return False

# Запуск бота
def start_bot(bot_path):
    subprocess.Popen(["python3", bot_path])

# Остановка бота
def stop_bot(bot_path):
    subprocess.call(["pkill", "-f", bot_path])

class BotMenuApp(rumps.App):
    def __init__(self):
        super(BotMenuApp, self).__init__("🚀 Bots Menu")
        self.status_items = {}  # хранение элементов для обновления статуса

        for bot_name in BOTS:
            # Элемент статуса
            status_item = rumps.MenuItem(f"{bot_name} - Status: 🔴 Stopped")
            self.status_items[bot_name] = status_item
            self.menu.add(status_item)

            # Кнопки Start и Stop
            start_item = rumps.MenuItem(f"Start {bot_name}", callback=lambda sender, name=bot_name: start_bot(BOTS[name]))
            stop_item = rumps.MenuItem(f"Stop {bot_name}", callback=lambda sender, name=bot_name: stop_bot(BOTS[name]))
            self.menu.add(start_item)
            self.menu.add(stop_item)

        # Таймер обновления статуса каждую минуту
        self.timer = rumps.Timer(self.update_status, 60)
        self.timer.start()

    # Функция обновления статуса ботов
    def update_status(self, _):
        for bot_name in BOTS:
            status = "🟢 Running" if is_running(BOTS[bot_name]) else "🔴 Stopped"
            self.status_items[bot_name].title = f"{bot_name} - Status: {status}"

if __name__ == "__main__":
    BotMenuApp().run()

