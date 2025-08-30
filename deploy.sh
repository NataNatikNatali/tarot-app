#!/bin/bash
set -e

cd ~/tarot-app/tarot-app || exit

echo "🚀 Форс-пушим проект на GitHub..."
git push origin main --force || true

echo ""
echo "⏳ Ищу последнюю сборку..."
LATEST_RUN=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/repos/NataNatikNatali/tarot-app/actions/runs \
  | grep '"id":' | head -1 | sed 's/[^0-9]//g')

if [ -n "$LATEST_RUN" ]; then
  echo "✅ Последний workflow ID: $LATEST_RUN"
  echo "👉 Страница сборки: https://github.com/NataNatikNatali/tarot-app/actions/runs/$LATEST_RUN"
  echo ""
  echo "⏳ Ищу артефакт APK..."
  ARTIFACT_URL=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
    https://api.github.com/repos/NataNatikNatali/tarot-app/actions/runs/$LATEST_RUN/artifacts \
    | grep '"archive_download_url"' | head -1 | cut -d '"' -f 4)
  if [ -n "$ARTIFACT_URL" ]; then
    echo "✅ Найден APK!"
    echo "👉 Скачай здесь (нужен вход в GitHub):"
    echo "   $ARTIFACT_URL"
  else
    echo "⚠️ APK ещё не готов. Зайди позже на страницу сборки:"
    echo "   https://github.com/NataNatikNatali/tarot-app/actions/runs/$LATEST_RUN"
  fi
else
  echo "⚠️ Не удалось найти последнюю сборку."
  echo "👉 Проверь вручную: https://github.com/NataNatikNatali/tarot-app/actions"
fi
#!/bin/bash
set -e

echo "🔄 Проверяем GitHub origin..."
cd ~/tarot-app/tarot-app || exit

# === 1. Делаем коммит и пуш ===
git add .
git commit -m "Автодеплой APK" || echo "⚠️ Нет новых изменений для коммита."
git push -u origin main --force

# === 2. Ждём запуска workflow ===
echo "⏳ Ищу последнюю сборку..."
LATEST_RUN=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/repos/NataNatikNatali/tarot-app/actions/runs \
  | grep '"id":' | head -1 | sed 's/[^0-9]//g')

if [ -z "$LATEST_RUN" ]; then
  echo "⚠️ Не удалось получить ID последней сборки."
  exit 1
fi

echo "✅ Последний workflow ID: $LATEST_RUN"
echo "👉 Страница сборки: https://github.com/NataNatikNatali/tarot-app/actions/runs/$LATEST_RUN"

# === 3. Ждём появления артефакта APK ===
echo "⏳ Жду сборку APK..."
for i in {1..20}; do
  ARTIFACT_URL=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
    https://api.github.com/repos/NataNatikNatali/tarot-app/actions/runs/$LATEST_RUN/artifacts \
    | grep '"archive_download_url"' | head -1 | cut -d '"' -f 4)

  if [ -n "$ARTIFACT_URL" ]; then
    echo "✅ Найден APK! Скачиваю..."
    mkdir -p ~/tarot-app/apk
    curl -L -H "Authorization: token $GITHUB_TOKEN" \
      -o ~/tarot-app/apk/apk.zip "$ARTIFACT_URL"
    unzip -o ~/tarot-app/apk/apk.zip -d ~/tarot-app/apk
    rm ~/tarot-app/apk/apk.zip
    echo "📱 APK сохранён сюда: ~/tarot-app/apk/app-debug.apk"
    exit 0
  fi

  echo "⏳ Пока не готово, жду 15 секунд..."
  sleep 15
done

echo "⚠️ APK так и не появился. Попробуй позже вручную."
0

