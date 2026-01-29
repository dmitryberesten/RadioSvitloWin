"""
Радіо Світло - Десктопний додаток
Онлайн радіо для Windows
"""

import webview
import threading
import socket
import tkinter as tk
from tkinter import messagebox
import sys
import os
from PIL import Image


def check_internet_connection():
    """Перевірка наявності інтернет-з'єднання"""
    try:
        # Спроба підключення до Google DNS
        socket.create_connection(("8.8.8.8", 53), timeout=3)
        return True
    except OSError:
        return False


def show_error_message():
    """Показати повідомлення про відсутність інтернету"""
    root = tk.Tk()
    root.withdraw()  # Приховати головне вікно
    messagebox.showerror(
        "Помилка підключення",
        "❌ Відсутнє інтернет-з'єднання\n\n"
        "Будь ласка, перевірте:\n"
        "• Підключення до мережі\n"
        "• Роутер або модем\n"
        "• Налаштування мережі\n\n"
        "Спробуйте перезапустити додаток після відновлення з'єднання."
    )
    root.destroy()


def on_closing():
    """Обробка закриття вікна з підтвердженням"""
    root = tk.Tk()
    root.withdraw()
    
    result = messagebox.askyesno(
        "Radio Svitlo",
        "Закрити додаток?",
        icon='question'
    )
    
    root.destroy()
    return result


class RadioSvitloApp:
    """Головний клас додатка"""
    
    def __init__(self):
        self.window = None
        self.url = "https://www.radio-svitlo.com"
        self.title = "Radio Svitlo"
        self.width = 770
        self.height = 600
        # Шлях до іконки
        base_dir = os.path.dirname(os.path.abspath(__file__))
        self.icon_png = os.path.join(base_dir, 'logo_svitlo.png')
        self.icon_ico = os.path.join(base_dir, 'logo_svitlo.ico')
        
    def prepare_icon(self):
        """Конвертація PNG у ICO для іконки вікна"""
        try:
            if os.path.exists(self.icon_png):
                # Якщо ICO не існує, конвертуємо PNG в ICO
                if not os.path.exists(self.icon_ico):
                    img = Image.open(self.icon_png)
                    img.save(self.icon_ico, format='ICO', sizes=[(256, 256), (128, 128), (64, 64), (32, 32), (16, 16)])
                return self.icon_ico
            return None
        except Exception as e:
            print(f"Помилка конвертації іконки: {e}")
            # Якщо конвертація не вдалася, спробуємо використати PNG
            return self.icon_png if os.path.exists(self.icon_png) else None
    
    def set_window_icon(self):
        """Встановлення іконки вікна після його створення"""
        icon_path = self.prepare_icon()
        if icon_path and os.path.exists(icon_path):
            try:
                self.window.icon = icon_path
                print(f"Іконка встановлена: {icon_path}")
            except Exception as e:
                print(f"Помилка встановлення іконки: {e}")
        
    def create_window(self):
        """Створення вікна додатка"""
        # Підготовка іконки
        icon_path = self.prepare_icon()
        
        # Створення вікна
        self.window = webview.create_window(
            self.title,
            self.url,
            width=self.width,
            height=self.height,
            resizable=True,
            fullscreen=False,
            min_size=(800, 600),
            confirm_close=False,  # Вимкнено стандартне, використовуємо своє
            on_top=False,
            frameless=False,
            easy_drag=False,
            text_select=False
        )
        
        # Встановлення обробника закриття
        self.window.events.closing += on_closing
        
        # Встановлення іконки, якщо вона існує
        if icon_path and os.path.exists(icon_path):
            self.window.icon = icon_path
        
    def start(self):
        """Запуск додатка"""
        # Перевірка інтернет-з'єднання
        if not check_internet_connection():
            show_error_message()
            sys.exit(1)
        
        # Створення вікна
        self.create_window()
        
        # Запуск додатка
        webview.start(
            debug=False,
            http_server=False,
            gui='edgechromium'  # Використання Edge WebView2 для Windows
        )


def main():
    """Головна функція"""
    app = RadioSvitloApp()
    app.start()


if __name__ == "__main__":
    main()
