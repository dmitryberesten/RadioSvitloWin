; =====================================
; Інсталятор Радіо Світло
; Створено через Inno Setup
; =====================================

#define MyAppName "Radio Svitlo"
#define MyAppVersion "1.3.0"
#define MyAppPublisher "Дмитро Берестень"
#define MyAppURL "https://www.radio-svitlo.com"
#define MyAppExeName "RadioSvitlo.exe"
#define MyAppIconName "logo_svitlo.ico"

[Setup]
; Основна інформація
AppId={{F5A7C8D9-3B2E-4F1A-9C7D-8E6B5A4C3D2E}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}

; Шляхи встановлення
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes

; Іконка установщика
SetupIconFile=logo_svitlo.ico
UninstallDisplayIcon={app}\{#MyAppIconName}

; Вихідні файли
OutputDir=installer_output
OutputBaseFilename=RadioSvitlo_Setup_v{#MyAppVersion}

; Стиснення
Compression=lzma2/max
SolidCompression=yes

; Режим встановлення
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog

; Візуальне оформлення
WizardStyle=modern
; Закоментовано образи - використовуємо стандартні
;WizardImageFile=compiler:WizModernImage-IS.bmp
;WizardSmallImageFile=compiler:WizModernSmallImage-IS.bmp

; Налаштування
AllowNoIcons=yes
DisableWelcomePage=no
DisableFinishedPage=no

; Мови
ShowLanguageDialog=auto

[Languages]
Name: "ukrainian"; MessagesFile: "compiler:Languages\Ukrainian.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"
Name: "quicklaunchicon"; Description: "Створити іконку на панелі швидкого запуску"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; Головний виконуваний файл
Source: "dist\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
; Іконки
Source: "logo_svitlo.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "logo_svitlo.png"; DestDir: "{app}"; Flags: ignoreversion 

[Icons]
; Іконка в меню Пуск
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\{#MyAppIconName}"
Name: "{group}\Відвідати сайт"; Filename: "{#MyAppURL}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"; IconFilename: "{app}\{#MyAppIconName}"

; Іконка на робочому столі
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\{#MyAppIconName}"; Tasks: desktopicon

; Іконка швидкого запуску
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\{#MyAppIconName}"; Tasks: quicklaunchicon

[Run]
; Запуск після встановлення (опціонально)
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
; Видалення додаткових файлів при деінсталяції
Type: filesandordirs; Name: "{app}"

[Code]
// Перевірка, чи програма вже запущена
function InitializeSetup(): Boolean;
var
  ResultCode: Integer;
begin
  Result := True;
  // Можна додати перевірку запущених процесів
end;

// Очистка кешу іконок Windows
procedure ClearIconCache();
var
  ResultCode: Integer;
  LocalAppData: String;
begin
  LocalAppData := ExpandConstant('{localappdata}');
  
  // Видалення основного файлу кешу іконок
  DeleteFile(LocalAppData + '\IconCache.db');
  
  // Видалення файлів кешу в папці Explorer
  DelTree(LocalAppData + '\Microsoft\Windows\Explorer\iconcache*.db', False, True, False);
  DelTree(LocalAppData + '\Microsoft\Windows\Explorer\thumbcache*.db', False, True, False);
  
  // Перезапуск Explorer для застосування змін
  Exec('taskkill', '/f /im explorer.exe', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  Sleep(1000);
  Exec(ExpandConstant('{win}\explorer.exe'), '', '', SW_SHOW, ewNoWait, ResultCode);
end;

// Повідомлення після успішної установки
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    // Очищення кешу іконок Windows після установки
    ClearIconCache();
  end;
end;

[Messages]
ukrainian.WelcomeLabel1=Ласкаво просимо до майстра встановлення [name]
ukrainian.WelcomeLabel2=Програма встановить [name/ver] на ваш комп'ютер.%n%nРекомендується закрити всі інші додатки перед продовженням.
ukrainian.FinishedHeadingLabel=Завершення встановлення [name]
ukrainian.FinishedLabelNoIcons=Програма [name] успішно встановлена на ваш комп'ютер.
ukrainian.FinishedLabel=Програма [name] успішно встановлена. Додаток можна запустити за допомогою встановлених ярликів.
ukrainian.ClickFinish=Натисніть «Завершити», щоб вийти з майстра встановлення.
