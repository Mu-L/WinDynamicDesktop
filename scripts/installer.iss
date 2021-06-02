; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "WinDynamicDesktop"
#define MyAppVersion GetVersionNumbersString("..\src\bin\Release\WinDynamicDesktop.exe")
#define MyAppPublisher "Timothy Johnson"
#define MyAppURL "https://github.com/t1m0thyj/WinDynamicDesktop"
#define MyAppExeName "WinDynamicDesktop.exe"
#define MyAppAssocName "Dynamic Desktop Wallpaper"
#define MyAppAssocExt ".ddw"
#define MyAppAssocKey MyAppName + "." + StringChange(MyAppAssocName, " ", "")

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{D457A4A2-5B1B-4767-97DF-F8F4FD36875E}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
ChangesAssociations=yes
DisableProgramGroupPage=yes
; Remove the following line to run in administrative install mode (install for all users.)
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
OutputBaseFilename={#MyAppName}_{#MyAppVersion}_Setup
Compression=lzma
SolidCompression=yes
WizardStyle=modern
CloseApplications=force
LicenseFile=..\LICENSE
OutputDir=..\dist

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "armenian"; MessagesFile: "compiler:Languages\Armenian.isl"
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"
Name: "catalan"; MessagesFile: "compiler:Languages\Catalan.isl"
Name: "corsican"; MessagesFile: "compiler:Languages\Corsican.isl"
Name: "czech"; MessagesFile: "compiler:Languages\Czech.isl"
Name: "danish"; MessagesFile: "compiler:Languages\Danish.isl"
Name: "dutch"; MessagesFile: "compiler:Languages\Dutch.isl"
Name: "finnish"; MessagesFile: "compiler:Languages\Finnish.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "hebrew"; MessagesFile: "compiler:Languages\Hebrew.isl"
Name: "icelandic"; MessagesFile: "compiler:Languages\Icelandic.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"
Name: "norwegian"; MessagesFile: "compiler:Languages\Norwegian.isl"
Name: "polish"; MessagesFile: "compiler:Languages\Polish.isl"
Name: "portuguese"; MessagesFile: "compiler:Languages\Portuguese.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "slovak"; MessagesFile: "compiler:Languages\Slovak.isl"
Name: "slovenian"; MessagesFile: "compiler:Languages\Slovenian.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"
Name: "turkish"; MessagesFile: "compiler:Languages\Turkish.isl"
Name: "ukrainian"; MessagesFile: "compiler:Languages\Ukrainian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "startonboot"; Description: "&Start {#MyAppName} with Windows"; GroupDescription: "Other tasks:"
Name: "registerddw"; Description: "&Associate .ddw extension with {#MyAppName}"; GroupDescription: "Other tasks:"

[Files]
Source: "..\src\bin\Release\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Registry]
Root: HKA; Subkey: "Software\Microsoft\Windows\CurrentVersion\Run"; ValueType: string; ValueName: "{#MyAppName}"; ValueData: "{app}\{#MyAppExeName}"; Flags: uninsdeletevalue; Tasks: startonboot
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocExt}\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppAssocKey}"; ValueData: ""; Flags: uninsdeletekeyifempty uninsdeletevalue; Tasks: registerddw
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}"; ValueType: string; ValueName: ""; ValueData: "{#MyAppAssocName}"; Flags: uninsdeletekey; Tasks: registerddw
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},0"; Tasks: registerddw
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Tasks: registerddw
Root: HKA; Subkey: "Software\Classes\Applications\{#MyAppExeName}\SupportedTypes"; ValueType: string; ValueName: ".myp"; ValueData: ""; Flags: uninsdeletekeyifempty; Tasks: registerddw

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall

[UninstallRun]
Filename: "{sys}\taskkill.exe"; Parameters: "/im {#MyAppExeName} /t /f"; RunOnceId: "KillApp"; Flags: runhidden skipifdoesntexist

[Code]
function InitializeSetup(): Boolean;
begin
  if not IsDotNetInstalled(net45, 0) then begin
    MsgBox('{#MyAppName} requires Microsoft .NET Framework 4.5 or newer to be installed.'#13#13
      'Download and install .NET Framework from'#13
      'http://www.microsoft.com/net/ and then rerun Setup.', mbCriticalError, MB_OK);
    Result := false;
  end else
    Result := true;
end;

procedure CurStepChanged(CurStep : TSetupStep);
begin
  if (CurStep = ssPostInstall) and IsAdminInstallMode() then
    SaveStringToFile(ExpandConstant('{app}\{#MyAppName}.pth'), ExpandConstant('%LocalAppData%\{#MyAppName}'), false);
end;

procedure DeleteUserData;
begin
  DelTree(ExpandConstant('{app}\scripts'), true, true, true);
  DelTree(ExpandConstant('{app}\themes'), true, true, true);
  DeleteFile(ExpandConstant('{app}\settings.json'));
  DeleteFile(ExpandConstant('{app}\{#MyAppExeName}.log'));
  DeleteFile(ExpandConstant('{app}\{#MyAppName}.pth'));
  RemoveDir(ExpandConstant('{app}'));
end;

procedure CurUninstallStepChanged(CurUninstallStep : TUninstallStep);
begin
  if CurUninstallStep = usPostUninstall then begin
    if MsgBox('Do you want to delete user data ({#MyAppName} settings and theme files)?',
        mbConfirmation, MB_YESNO or MB_DEFBUTTON2) = IDYES then
      DeleteUserData;
  end;
end;

