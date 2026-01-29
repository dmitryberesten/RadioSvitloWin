@echo off
REM =====================================
REM Скрипт збірки Радіо Світло в EXE
REM =====================================

echo ========================================
echo  Збірка Радіо Світло
echo ========================================
echo.

REM Перевірка активації віртуального середовища
if not defined VIRTUAL_ENV (
    echo Активуємо віртуальне середовище...
    call .venv\Scripts\activate.bat
)

REM Встановлення необхідних пакетів
echo Перевірка залежностей...
pip install -r requirements.txt
echo.

REM Очистка попередніх збірок
echo Очищення попередніх збірок...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist
echo.

REM Збірка EXE файлу
echo ========================================
echo Збірка EXE файлу з PyInstaller...
echo ========================================
pyinstaller --clean radio_svitlo.spec

REM Перевірка успішності збірки
if exist dist\RadioSvitlo.exe (
    echo.
    echo ========================================
    echo ✓ Збірка успішна!
    echo ========================================
    echo EXE файл: dist\RadioSvitlo.exe
    echo.
    echo Тепер запустіть build_installer.bat
    echo для створення установщика!
    echo ========================================
) else (
    echo.
    echo ========================================
    echo ✗ Помилка збірки!
    echo ========================================
    pause
    exit /b 1
)

pause
