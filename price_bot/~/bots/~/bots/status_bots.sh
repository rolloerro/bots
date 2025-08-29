#!/usr/bin/env bash
echo "📊 Статус процессов:"
ps aux | grep universal_bot.py | grep -v grep
