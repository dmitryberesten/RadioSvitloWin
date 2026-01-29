#!/bin/bash
# =====================================
# Bash скрипт для тестування EXE
# =====================================

echo "========================================"
echo " Тестування RadioSvitlo.exe"
echo "========================================"
echo ""

if [ ! -f "dist/RadioSvitlo.exe" ]; then
    echo "✗ EXE файл не знайдено!"
    echo ""
    echo "Спочатку запустіть ./build_exe.sh"
    echo "для створення EXE файлу."
    echo ""
    exit 1
fi

echo "✓ EXE файл знайдено: dist/RadioSvitlo.exe"
echo ""

# Показати інформацію про файл
ls -lh dist/RadioSvitlo.exe
echo ""

echo "Запуск додатка для тестування..."
echo "Перевірте:"
echo "  ✓ Іконка вікна (має бути logo_svitlo)"
echo "  ✓ Завантаження сайту radio-svitlo.com"
echo "  ✓ Відсутність помилок"
echo ""

# Запуск EXE
cmd //c start "" "dist\\RadioSvitlo.exe"

echo ""
echo "Додаток запущено!"
echo "Закрийте це вікно після тестування."
echo ""
