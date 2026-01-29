# -*- mode: python ; coding: utf-8 -*-
"""
PyInstaller spec файл для Радіо Світло
Створює exe файл з іконкою та всіма необхідними залежностями
"""

block_cipher = None

a = Analysis(
    ['radio_svitlo.py'],
    pathex=[],
    binaries=[],
    datas=[
        ('logo_svitlo.png', '.'),  # Додаємо PNG іконку
        ('logo_svitlo.ico', '.'),  # Додаємо ICO іконку
    ],
    hiddenimports=[
        'webview',
        'tkinter',
        'PIL',
        'PIL.Image',
        'socket',
    ],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
    noarchive=False,
)

pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.zipfiles,
    a.datas,
    [],
    name='RadioSvitlo',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,  # Без консолі (GUI додаток)
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon='logo_svitlo.ico',  # Іконка exe файлу
    version_file=None,
    uac_admin=False,  # Не потребує прав адміністратора
    uac_uiaccess=False,
)
