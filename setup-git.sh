
#!/bin/bash

# Настройка имени и почты для Git
git config --global user.name "NataNatiK"
git config --global user.email "navinatik@gmail.com"

# Проверяем, есть ли ветка main
if ! git rev-parse --verify main >/dev/null 2>&1; then
  echo "⚡ Создаю ветку main..."
  git checkout -b main
fi

# Удаляем старый origin (если есть) и добавляем новый
git remote remove origin 2>/dev/null
git remote add origin https://github.com/natanatiknatali/tarot-app.git

# Добавляем все файлы
git add .

# Делаем первый коммит
git commit -m "Initial commit" || echo "✅ Коммит уже существует"

# Отправляем на GitHub
git push -u origin main
0

