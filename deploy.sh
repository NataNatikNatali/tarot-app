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
