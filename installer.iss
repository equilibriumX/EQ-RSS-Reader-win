#define MyAppName "EQ-RSS Reader"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Barnak"
#define MyAppExeName "EQ-RSS-Reader.exe"

[Setup]
AppId={{B6D0B1B5-6B4B-4D1D-9A2D-7E9F3A4C1D20}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\EQ-RSS Reader
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
OutputDir=installer-output
OutputBaseFilename=EQ-RSS-Reader-Setup
SetupIconFile=resources\eq-rssnews.ico
UninstallDisplayIcon={app}\{#MyAppExeName}
ArchitecturesInstallIn64BitMode=x64
PrivilegesRequired=lowest
WizardStyle=modern
Compression=lzma2
SolidCompression=yes
LicenseFile=LICENSE
InfoBeforeFile=README.md

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional shortcuts:"; Flags: unchecked
Name: "startup"; Description: "Start EQ-RSS Reader when I sign in to Windows"; GroupDescription: "Startup:"; Flags: unchecked

[Files]
Source: "package\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "LICENSE"; DestDir: "{app}"; Flags: ignoreversion
Source: "THIRD_PARTY_NOTICES.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "README.md"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\EQ-RSS Reader"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\EQ-RSS Reader"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userstartup}\EQ-RSS Reader"; Filename: "{app}\{#MyAppExeName}"; Tasks: startup

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Launch EQ-RSS Reader"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: "{app}\cache"
