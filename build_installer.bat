@echo off
REM =====================================
REM Скрипт створення установщика через Inno Setup
REM =====================================

echo ========================================
echo  Створення установщика Радіо Світло
echo ========================================
echo.

REM Перевірка наявності EXE файлу
if not exist dist\RadioSvitlo.exe (
    echo ✗ Помилка: EXE файл не знайдено!
    echo.
    echo Спочатку виконайте build_exe.bat
    echo для створення EXE файлу.
    echo.
    pause
    exit /b 1
)

REM Перевірка наявності Inno Setup
echo Перевірка Inno Setup...
where iscc >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ========================================
    echo ✗ Помилка: Inno Setup не знайдено!
    echo ========================================
    echo.
    echo Можливі шляхи до Inno Setup:
    if exist "C:\Program Files (x86)\Inno Setup 6\iscc.exe" (
        echo ✓ Знайдено: C:\Program Files ^(x86^)\Inno Setup 6\iscc.exe
        echo.
        echo Спробую використати прямий шлях...
        set "ISCC=C:\Program Files (x86)\Inno Setup 6\iscc.exe"
        goto :compile
    )
    if exist "C:\Program Files\Inno Setup 6\iscc.exe" (
        echo ✓ Знайдено: C:\Program Files\Inno Setup 6\iscc.exe
        echo.
        echo Спробую використати прямий шлях...
        set "ISCC=C:\Program Files\Inno Setup 6\iscc.exe"
        goto :compile
    )
    echo.
    echo ✗ Inno Setup не встановлено!
    echo.
    echo Щоб створити установщик:
    echo 1. Завантажте Inno Setup: https://jrsoftware.org/isdl.php
    echo 2. Встановіть програму
    echo 3. Перезапустіть цей скрипт
    echo.
    echo АБО використайте вже створений EXE файл:
    echo    dist\RadioSvitlo.exe
    echo.
    pause
    exit /b 1
) else (
    set "ISCC=iscc"
)

:compile

REM Створення директорії для установщика
if not exist installer_output mkdir installer_output

REM Компіляція установщика
echo.
echo ========================================
echo Компіляція установщика з Inno Setup...
echo ========================================
echo.
echo Використовується: %ISCC%
echo Файл конфігурації: installer.iss
echo.
"%ISCC%" installer.iss
set COMPILE_ERROR=%errorlevel%
echo.
if %COMPILE_ERROR% neq 0 (
    echo ✗ Помилка компіляції! Код: %COMPILE_ERROR%
    echo.
    pause
    exit /b %COMPILE_ERROR%
)

REM Перевірка успішності
if exist installer_output\RadioSvitlo_Setup_v*.exe (
    echo.
    echo ========================================
    echo ✓ Установщик успішно створено!
    echo ========================================
    echo.
    for %%f in (installer_output\RadioSvitlo_Setup_v*.exe) do (
        echo Файл: %%f
        echo Розмір: %%~zf байт
    )
    echo.
    echo Тепер ви можете розповсюджувати цей
    echo установщик для встановлення програми
    echo на інших комп'ютерах!
    echo ========================================
    echo.
    
    REM Відкриття папки з установщиком
    start explorer installer_output
) else (
    echo.
    echo ========================================
    echo ✗ Помилка створення установщика!
    echo ========================================
    pause
    exit /b 1
)

pause
