; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "GloSC"
#define MyAppVersion "2.0.6"
#define MyAppPublisher "Peter Repukat - FlatspotSoftware"
#define MyAppURL "https://github.com/Alia5/GloSC"
#define MyAppExeName "GloSC.exe"
#define GloSCLauncherName "GloSC_GameLauncher.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{60BEAC2A-F5B7-4C81-9EB6-CF9FE75E7329}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
OutputDir=installer
LicenseFile=License.txt
InfoBeforeFile=Readme.md
OutputBaseFilename=GloSC-installer
PrivilegesRequired=admin
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "build\Win32\Release\GloSC.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "build\Win32\Release\GloSC_Watchdog.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "build\Win32\Release\SteamTarget.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "dependencies\SFML-2.4.2-x86\bin\sfml-system-2.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dependencies\SFML-2.4.2-x86\bin\sfml-window-2.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dependencies\SFML-2.4.2-x86\bin\sfml-graphics-2.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "License.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Qt\5.13.1\msvc2017\bin\Qt5Core.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Qt\5.13.1\msvc2017\bin\Qt5Gui.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Qt\5.13.1\msvc2017\bin\Qt5Widgets.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Qt\5.13.1\msvc2017\bin\Qt5Network.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "build\Win32\Release\EnforceBindingDLL.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "qt-license.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "Readme.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "TargetConfig.ini"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Qt\5.13.1\msvc2017\plugins\platforms\qwindows.dll"; DestDir: "{app}\platforms"; Flags: ignoreversion
Source: "redist\vc_redist_x86.exe"; DestDir: "{app}\redist"; Flags: ignoreversion
Source: "redist\libeay32.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "redist\ssleay32.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "redist\OpenSSL License.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "redist\ViGEmClient.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dependencies\minhook\MH_LICENSE.txt"; DestDir: "{app}"; Flags: ignoreversion
;
; NOTE: ViGEmBus installer and KB3033929 MSU's have to be downloaded separately and placed in the source redist directory
;
Source: "redist\ViGEmBus_Setup_1.16.115.exe"; DestDir: "{app}\redist"; Flags: ignoreversion
Source: "redist\ViGEmBus-LICENSE.txt"; DestDir: "{app}\redist"; Flags: ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
; vc++ platform redist
Filename: "{app}\redist\vc_redist_x86.exe"; Parameters: "/quiet /install"; Description: "Installing Redist. packages"; Flags: runascurrentuser
; vigembus driver install
Filename: "{app}\redist\ViGEmBus_Setup_1.16.115.exe"; Description: "Install ViGEmBus Driver"; Flags: nowait postinstall skipifsilent

; install glosc after prereqs
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: runascurrentuser nowait postinstall skipifsilent


[InstallDelete]
Type: files; Name: "{app}"

[Code]
/////////////////////////////////////////////////////////////////////
function GetUninstallString(): String;
var
  sUnInstPath: String;
  sUnInstallString: String;
begin
  sUnInstPath := ExpandConstant('Software\Microsoft\Windows\CurrentVersion\Uninstall\{#emit SetupSetting("60BEAC2A-F5B7-4C81-9EB6-CF9FE75E7329")}_is1');
  sUnInstallString := '';
  if not RegQueryStringValue(HKLM, sUnInstPath, 'UninstallString', sUnInstallString) then
    RegQueryStringValue(HKCU, sUnInstPath, 'UninstallString', sUnInstallString);
  Result := sUnInstallString;
end;


/////////////////////////////////////////////////////////////////////
function IsUpgrade(): Boolean;
begin
  Result := (GetUninstallString() <> '');
end;


/////////////////////////////////////////////////////////////////////
function UnInstallOldVersion(): Integer;
var
  sUnInstallString: String;
  iResultCode: Integer;
begin
// Return Values:
// 1 - uninstall string is empty
// 2 - error executing the UnInstallString
// 3 - successfully executed the UnInstallString

  // default return value
  Result := 0;

  // get the uninstall string of the old app
  sUnInstallString := GetUninstallString();
  if sUnInstallString <> '' then begin
    sUnInstallString := RemoveQuotes(sUnInstallString);
    if Exec(sUnInstallString, '/SILENT /NORESTART /SUPPRESSMSGBOXES','', SW_HIDE, ewWaitUntilTerminated, iResultCode) then
      Result := 3
    else
      Result := 2;
  end else
    Result := 1;
end;

/////////////////////////////////////////////////////////////////////
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if (CurStep=ssInstall) then
  begin
    if (IsUpgrade()) then
    begin
      UnInstallOldVersion();
    end;
  end;
end;
