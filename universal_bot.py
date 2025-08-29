#!/usr/bin/env python3
import logging, argparse
from telegram import Update
from telegram.ext import ApplicationBuilder, CommandHandler, MessageHandler, ContextTypes, filters

logging.basicConfig(
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
    level=logging.INFO,
)

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text(f"Привет! Я бот {context.bot_data['name']} 🤖")

async def echo(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text(update.message.text)

def main():
    parser = argparse.ArgumentParser(description="Universal Telegram Bot")
    parser.add_argument("--token", required=True, help="Bot token")
    parser.add_argument("--name", required=True, help="Bot name")
    args = parser.parse_args()

    app = ApplicationBuilder().token(args.token).build()
    app.bot_data["name"] = args.name

    app.add_handler(CommandHandler("start", start))
    app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, echo))

    logging.info(f"Запускаем {args.name}...")
    app.run_polling()

if __name__ == "__main__":
    main()
