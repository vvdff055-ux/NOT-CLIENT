; =====================================================================
; NOTCLIENT - CUSTOM PVP MULTI-MODULE HUB WITH CLEAN SKIN INTEGRATION
; =====================================================================
#define AppName "NotClient"
#define AppURL "https://skmedix.pl"
#define AppVersion "10.0.0.0"
#define AppVersionPretty "10.0.0"
#define AppAuthor "Sudip Dev"
#define AppDir "notclient"
#define MainJarFile "NotClient.jar"

[Setup]
; Put Inno Setup outputs into installer/Output so workflow can upload reliably
OutputDir=installer/Output
AppId={{A151427E-7A46-4D6D-8534-C4C04BADA77A}}
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher={#AppAuthor}
AppPublisherURL={#AppURL}
VersionInfoVersion={#AppVersion}
DefaultDirName={userappdata}\{#AppDir}
DisableProgramGroupPage=yes
DefaultGroupName={#AppName}
PrivilegesRequired=lowest
OutputBaseFilename={#AppName}_CleanPvP_Setup
SetupIconFile=..\icon.ico
UninstallDisplayIcon={app}\icon.ico
UninstallDisplayName={#AppName} Launcher
ArchiveExtraction=full
Compression=lzma
SolidCompression=yes
WizardStyle=modern
WizardResizable=no
WizardSmallImageFile=tmp\small.bmp
WizardImageFile=tmp\large.bmp
ExtraDiskSpaceRequired=209715200
DisableWelcomePage=no
DisableDirPage=auto
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
DirExistsWarning=no
MinVersion=6.1.7600

[Files]
Source: "..\{#MainJarFile}"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\icon.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "tmp\jre.zip"; DestDir: "{tmp}"; Flags: ignoreversion

[Icons]
Name: "{userdesktop}\{#AppName}"; Filename: "{app}\java\bin\javaw.exe"; Parameters: "-Xmx4096M -jar ""{app}\{#MainJarFile}"""; IconFilename: "{app}\icon.ico"; WorkingDir: "{app}"

[Dirs]
Name: "{userappdata}\.minecraft\{#AppDir}"
Name: "{userappdata}\.minecraft\{#AppDir}\mods"
Name: "{userappdata}\.minecraft\{#AppDir}\resourcepacks"
Name: "{userappdata}\.minecraft\{#AppDir}\shaderpacks"
Name: "{userappdata}\.minecraft\{#AppDir}\config"

[Messages]
WelcomeLabel1=NOTCLIENT GAMING HUB
WelcomeLabel2=Custom PvP UI Edition - High performance optimization engine featuring filtered modules grid layout and global skin visibility.

[Code]
procedure OpenDiscordLink(Sender: TObject);
var
  ErrorCode: Integer;
begin
  ShellExec('open', 'https://discord.gg', '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
end;

procedure OpenPartnerLink(Sender: TObject);
var
  ErrorCode: Integer;
begin
  ShellExec('open', 'https://discord.gg', '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
end;

procedure GenerateInGameHUDConfig;
var
  ConfigFilePath: String;
  ConfigData: TStringList;
begin
  ConfigFilePath := ExpandConstant('{userappdata}\.minecraft\{#AppDir}\config\mod_menu_settings.json');
  ConfigData := TStringList.Create;
  try
    ConfigData.Add('{');
    ConfigData.Add('  "client_branding": "NotClient",');
    ConfigData.Add('  "ui_style": "custom_feather_grid",');
    ConfigData.Add('  "header_color": "#FF8C00",');
    ConfigData.Add('  "enabled_modules": {');
    ConfigData.Add('    "fps_counter": true,');
    ConfigData.Add('    "ping_display": true,');
    ConfigData.Add('    "cps_counter": true,');
    ConfigData.Add('    "full_bright": true,');
    ConfigData.Add('    "remove_hurt_shake": true,');
    ConfigData.Add('    "damage_indicator": true,');
    ConfigData.Add('    "nametags": true,');
    ConfigData.Add('    "global_skins": true');
    ConfigData.Add('  },');
    ConfigData.Add('  "removed_modules": {');
    ConfigData.Add('    "cosmetics": false,');
    ConfigData.Add('    "auto_gg": false,');
    ConfigData.Add('    "quick_messages": false,');
    ConfigData.Add('    "notifications": false,');
    ConfigData.Add('    "durability_warning": false,');
    ConfigData.Add('    "toggle_sneak": false,');
    ConfigData.Add('    "zoom": false');
    ConfigData.Add('  },');
    ConfigData.Add('  "menu_keybind": "KEY_RSHIFT"');
    ConfigData.Add('}');
    ForceDirectories(ExtractFilePath(ConfigFilePath));
    ConfigData.SaveToFile(ConfigFilePath);
  finally
    ConfigData.Free;
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
    GenerateInGameHUDConfig;
end;
