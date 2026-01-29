@echo off
REM =====================================
REM Запуск та тестування EXE файлу
REM =====================================

echo ========================================
echo  Тестування RadioSvitlo.exe
echo ========================================
echo.

if not exist dist\RadioSvitlo.exe (
    echo ✗ EXE файл не знайдено!
    echo.
    echo Спочатку запустіть build_exe.bat
    echo для створення EXE файлу.
    echo.
    pause
    exit /b 1
)

echo ✓ EXE файл знайдено: dist\RadioSvitlo.exe
echo.

REM Показати інформацію про файл
for %%f in (dist\RadioSvitlo.exe) do (
    echo Розмір: %%~zf байт
    echo Дата створення: %%~tf
)
echo.

echo Запуск додатка для тестування...
echo Перевірте:
echo   ✓ Іконка вікна (має бути logo_svitlo)
echo   ✓ Завантаження сайту radio-svitlo.com
echo   ✓ Відсутність помилок
echo.

start "" "dist\RadioSvitlo.exe"

echo.
echo Додаток запущено!
echo Закрийте це вікно після тестування.
echo.
pause
