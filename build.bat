@echo off
echo ========================================
echo    Компіляція Радіо Світло у .exe
echo ========================================
echo.

REM Перевірка наявності PyInstaller
pip show pyinstaller >nul 2>&1
if %errorlevel% neq 0 (
    echo PyInstaller не знайдено. Встановлення...
    pip install pyinstaller
)

echo Початок компіляції...
echo.

REM Компіляція
pyinstaller ^
  --onefile ^
  --windowed ^
  --name="RadioSvitlo" ^
  --icon=logo_svitlo.png ^
  --add-data="logo_svitlo.png;." ^
  --clean ^
  --noconfirm ^
  radio_svitlo.py

echo.
if %errorlevel% equ 0 (
    echo ========================================
    echo   ✅ Компіляція успішно завершена!
    echo ========================================
    echo.
    echo 📁 Файл знаходиться в папці: dist\RadioSvitlo.exe
    echo.
    echo Ви можете передати цей файл користувачам.
    echo Для роботи потрібен встановлений Edge WebView2 Runtime.
) else (
    echo ========================================
    echo   ❌ Помилка компіляції!
    echo ========================================
    echo.
    echo Перевірте помилки вище.
)

echo.
pause
