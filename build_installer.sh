#!/bin/bash
# =====================================
# Bash скрипт для створення установщика
# =====================================

echo "========================================"
echo " Створення установщика Радіо Світло"
echo "========================================"
echo ""

# Перевірка наявності EXE файлу
if [ ! -f "dist/RadioSvitlo.exe" ]; then
    echo "✗ Помилка: EXE файл не знайдено!"
    echo ""
    echo "Спочатку виконайте ./build_exe.sh"
    echo "для створення EXE файлу."
    echo ""
    exit 1
fi

# Перевірка наявності Inno Setup
if ! command -v iscc &> /dev/null; then
    echo "✗ Помилка: Inno Setup не знайдено!"
    echo ""
    echo "Завантажте та встановіть Inno Setup з:"
    echo "https://jrsoftware.org/isdl.php"
    echo ""
    echo "Після встановлення додайте шлях до iscc.exe в PATH"
    echo "або запустіть через Windows:"
    echo "  cmd //c build_installer.bat"
    echo ""
    exit 1
fi

# Створення директорії для установщика
mkdir -p installer_output

# Компіляція установщика
echo "========================================"
echo "Компіляція установщика з Inno Setup..."
echo "========================================"
echo ""
iscc installer.iss

# Перевірка результату
if ls installer_output/RadioSvitlo_Setup_v*.exe 1> /dev/null 2>&1; then
    echo ""
    echo "========================================"
    echo "✓ Установщик успішно створено!"
    echo "========================================"
    echo ""
    ls -lh installer_output/RadioSvitlo_Setup_v*.exe
    echo ""
    echo "Тепер ви можете розповсюджувати цей"
    echo "установщик для встановлення програми"
    echo "на інших комп'ютерах!"
    echo "========================================"
    echo ""
    
    # Відкриття папки з установщиком
    explorer installer_output
else
    echo ""
    echo "========================================"
    echo "✗ Помилка створення установщика!"
    echo "========================================"
    exit 1
fi
