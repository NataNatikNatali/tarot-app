#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "🔄 Обновление системы..."
pkg update -y && pkg upgrade -y

echo "📦 Установка Node.js, Git, Unzip, Wget, Python..."
pkg install -y nodejs git unzip wget python

echo "⚙️ Установка Expo и EAS CLI..."
npm install -g expo-cli eas-cli

echo "📥 Установка зависимостей проекта..."
npm install

echo "🏗 Сборка APK через EAS..."
eas build -p android --profile preview --local

echo "✅ Готово! APK смотри в папке ./build"
