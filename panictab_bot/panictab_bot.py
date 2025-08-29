import telebot, time
TOKEN = "ВАШ_ТОКЕН_БОТА"
CHAT_ID = 421796499
bot = telebot.TeleBot(TOKEN)
while True:
    bot.send_message(CHAT_ID, "panictab_bot работает ✅")
    time.sleep(60)
