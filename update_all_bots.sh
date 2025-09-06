#!/bin/bash
# 🚀 Скрипт для обновления всех ботов по отдельности

# Массив: папки с ботами
BOTS=("fdt_bot" "panictab_bot" "net_panic_bot" "price_bot")

# Проходим по каждому боту
for BOT in "${BOTS[@]}"
do
  echo "🔹 Обновляем $BOT ..."
  cd ~/bots/$BOT || { echo "❌ Папка $BOT не найдена!"; continue; }

  # Добавляем изменения
  git add .

  # Коммитим с текущей датой
  git commit -m "Обновление $BOT: $(date '+%Y-%m-%d %H:%M:%S')" || echo "⚠️ Нет изменений для $BOT"

  # Пушим на GitHub
  git push origin main || echo "⚠️ Не удалось отправить $BOT"

  echo "✅ $BOT обновлён"
  echo "------------------------"
done

echo "🎉 Все боты проверены и отправлены!"
