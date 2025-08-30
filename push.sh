#!/bin/bash
cd ~/tarot-app/tarot-app || exit

echo "🔄 Настраиваем GitHub origin..."
git remote remove origin 2>/dev/null
git remote add origin https://x-access-token:$GITHUB_TOKEN@github.com/natanatiknatali/tarot-app.git

git remote -v

echo "📦 Добавляем файлы..."
git add .

echo "📝 Делаем коммит..."
git commit -m "Initial commit" || echo "⚠️ Нет новых изменений для коммита."

echo "🚀 Отправляем проект на GitHub..."
git push -u origin main --force
