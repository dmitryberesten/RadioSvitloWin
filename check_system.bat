@echo off
REM =====================================
REM Перевірка готовності до збірки
REM =====================================

echo ========================================
echo  Перевірка системи
echo ========================================
echo.

REM Перевірка Python
echo [1/5] Перевірка Python...
python --version >nul 2>&1
if %errorlevel% equ 0 (
    python --version
    echo ✓ Python встановлено
) else (
    echo ✗ Python не знайдено
)
echo.

REM Перевірка віртуального середовища
echo [2/5] Перевірка віртуального середовища...
if exist ".venv\Scripts\activate.bat" (
    echo ✓ Віртуальне середовище: .venv\
) else (
    echo ✗ Віртуальне середовище не знайдено
)
echo.

REM Перевірка PyInstaller
echo [3/5] Перевірка PyInstaller...
if defined VIRTUAL_ENV (
    pyinstaller --version >nul 2>&1
    if %errorlevel% equ 0 (
        pyinstaller --version
        echo ✓ PyInstaller встановлено
    ) else (
        echo ✗ PyInstaller не встановлено
        echo   Виконайте: pip install -r requirements.txt
    )
) else (
    echo ⚠ Активуйте віртуальне середовище:
    echo   .venv\Scripts\activate
)
echo.

REM Перевірка EXE файлу
echo [4/5] Перевірка EXE файлу...
if exist "dist\RadioSvitlo.exe" (
    for %%f in (dist\RadioSvitlo.exe) do (
        echo ✓ EXE файл створено
        echo   Розмір: %%~zf байт
        echo   Дата: %%~tf
    )
) else (
    echo ✗ EXE файл не знайдено
    echo   Виконайте: build_exe.bat
)
echo.

REM Перевірка Inno Setup
echo [5/5] Перевірка Inno Setup...
where iscc >nul 2>&1
if %errorlevel% equ 0 (
    for /f "delims=" %%i in ('where iscc') do echo ✓ Знайдено: %%i
    for /f "tokens=*" %%v in ('iscc /? ^| findstr "Inno Setup"') do echo   %%v
) else (
    if exist "C:\Program Files (x86)\Inno Setup 6\iscc.exe" (
        echo ⚠ Inno Setup встановлено, але не в PATH
        echo   Шлях: C:\Program Files ^(x86^)\Inno Setup 6\iscc.exe
        echo   Скрипт build_installer.bat знайде його автоматично
    ) else if exist "C:\Program Files\Inno Setup 6\iscc.exe" (
        echo ⚠ Inno Setup встановлено, але не в PATH
        echo   Шлях: C:\Program Files\Inno Setup 6\iscc.exe
        echo   Скрипт build_installer.bat знайде його автоматично
    ) else (
        echo ✗ Inno Setup не встановлено
        echo   Завантажити: https://jrsoftware.org/isdl.php
    )
)
echo.

REM Перевірка іконок
echo [БОНУС] Перевірка іконок...
if exist "logo_svitlo.ico" (
    echo ✓ logo_svitlo.ico
) else (
    echo ✗ logo_svitlo.ico не знайдено
)
if exist "logo_svitlo.png" (
    echo ✓ logo_svitlo.png
) else (
    echo ✗ logo_svitlo.png не знайдено
)
echo.

REM Підсумок
echo ========================================
echo  ПІДСУМОК
echo ========================================
echo.

if exist "dist\RadioSvitlo.exe" (
    echo ✅ EXE файл готовий до використання!
    echo    Запустити: test_exe.bat
    echo.
)

where iscc >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Можна створити установщик!
    echo    Запустити: build_installer.bat
) else (
    if exist "C:\Program Files (x86)\Inno Setup 6\iscc.exe" (
        echo ✅ Можна створити установщик!
        echo    Запустити: build_installer.bat
    ) else if exist "C:\Program Files\Inno Setup 6\iscc.exe" (
        echo ✅ Можна створити установщик!
        echo    Запустити: build_installer.bat
    ) else (
        echo ⚠ Для установщика потрібен Inno Setup
        echo    https://jrsoftware.org/isdl.php
    )
)
echo.
echo ========================================

pause
