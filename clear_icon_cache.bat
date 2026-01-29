@echo off
REM =====================================
REM Очищення кешу іконок Windows
REM =====================================

echo ========================================
echo  Очищення кешу іконок Windows
echo ========================================
echo.
echo Це допоможе оновити іконки на робочому
echo столі та панелі завдань після встановлення
echo нової версії програми.
echo.
echo ВАЖЛИВО: Explorer буде перезапущено!
echo.
pause

echo.
echo Очищення кешу іконок...
echo.

REM Видалення файлів кешу іконок
cd /d %userprofile%\AppData\Local

attrib -h IconCache.db 2>nul
del /f /q IconCache.db 2>nul

attrib -h Microsoft\Windows\Explorer\iconcache*.db 2>nul
del /f /q Microsoft\Windows\Explorer\iconcache*.db 2>nul

attrib -h Microsoft\Windows\Explorer\thumbcache*.db 2>nul
del /f /q Microsoft\Windows\Explorer\thumbcache*.db 2>nul

echo ✓ Кеш іконок видалено
echo.

REM Перезапуск Explorer
echo Перезапуск Explorer...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 /nobreak >nul
start explorer.exe

echo.
echo ========================================
echo ✓ Готово!
echo ========================================
echo.
echo Іконки має бути оновлено.
echo Якщо ні, перезавантажте комп'ютер.
echo.
pause
