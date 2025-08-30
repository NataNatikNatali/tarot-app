#!/bin/bash
cd ~/tarot-app/tarot-app || exit

echo "🧹 Чистим историю от токенов..."

# Удаляем коммиты с токенами из истории
git filter-repo --path setup.sh --invert-paths --force
git filter-repo --path update.sh --invert-paths --force

echo "🔄 Переписываем историю и отправляем на GitHub..."
git push origin --force --all
git push origin --force --tags

echo "✅ История очищена! Теперь GitHub больше не будет блокировать пуши."
