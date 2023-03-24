unit Principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, StrUtils, ClipBrd, ShellApi, Winapi.PsAPI, Winapi.SHFolder,
  Vcl.ComCtrls, DateUtils;

const TipoProduto: array[VER_NT_WORKSTATION..VER_NT_SERVER] of String = ('WORKSTATION','DOMAIN_CONTROLLER','SERVER');

type
  TForm3 = class(TForm)
    bVer: TBitBtn;
    lbV: TLabel;
    StatusBar1: TStatusBar;
    procedure bVerClick(Sender: TObject);
    function Arquitetura(Arch: TOSVersion.TArchitecture): String;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

function TForm3.Arquitetura(Arch: TOSVersion.TArchitecture): String;
begin
{ Não funciona
   case Arch of
      PROCESSOR_ARCHITECTURE_INTEL: Result := 'Intel x86';
      PROCESSOR_ARCHITECTURE_MIPS: Result := 'MIPS';
      PROCESSOR_ARCHITECTURE_ALPHA: Result := 'ALPHA';
      PROCESSOR_ARCHITECTURE_PPC: Result := 'PPC';
      PROCESSOR_ARCHITECTURE_SHX: Result := 'SHX';
      PROCESSOR_ARCHITECTURE_ARM: Result := 'ARM';
      PROCESSOR_ARCHITECTURE_IA64: Result := 'IA64';
      PROCESSOR_ARCHITECTURE_ALPHA64: Result := 'ALPHA64';
      PROCESSOR_ARCHITECTURE_MSIL: Result := 'MSIL';
      PROCESSOR_ARCHITECTURE_AMD64: Result := 'AMD64';
      PROCESSOR_ARCHITECTURE_IA32_ON_WIN64: Result := 'IA32_ON_WIN64';
      PROCESSOR_ARCHITECTURE_UNKNOWN: Result := 'Indefinido';
   else
      Result := 'Indefinido';
   end;
}

   case Arch of
      arIntelX86: Result := 'x86';
      arIntelX64: Result := 'x64';
      arARM32: Result := 'ARM32';
      arARM64: Result := 'ARM64';
   else
      Result := 'Indefinido';
   end;
end;
{
function ExecutaShell(Comando: String; AguardaRetorno: Boolean): Boolean;
var sPath: String;
    startupinfo: Tstartupinfo;
    ProcessInfo: TprocessInformation;
begin
   try
     sPath := ''; //ExtractFilePath(Application.ExeName);
     Comando := sPath+Comando;
//     sPath := '.\';
     FillChar(startupinfo,sizeof(Tstartupinfo),0);
     startupinfo.cb := sizeof(Tstartupinfo);
     if createProcess(nil, PChar(Comando),nil,nil,False,normal_priority_class,nil,nil,startupinfo,processinfo) and AguardaRetorno then
     begin
        waitforsingleobject(processinfo.hprocess,infinite);
     end;
     closehandle(processinfo.hprocess);
     Result := True;
   except
     Result := False;
   end;
end;
}
procedure TForm3.bVerClick(Sender: TObject);
var
  sSO, sSP, sMais, sAMajor, sAMinor, sABuild: String;
  VerInfo: TOSVersionInfoEx;
  SysInfo: TSystemInfo;
  iAMajor, iAMinor, iABuild: Cardinal;
  aa: TFormatSettings;
begin
   {$IFDEF MSWINDOWS}
      ZeroMemory(@VerInfo, SizeOf(VerInfo));
      VerInfo.dwOSVersionInfoSize := SizeOf(VerInfo);
      GetVersionEx(VerInfo);

//      ExecutaShell('cmd /C ver >> VersaoSO.txt',True);
//      ExecutaShell('cmd /C set VersaoSO=%ver%',True);

//      WinExec('cmd /C "set VersaoSO=%ver%"',WS_MINIMIZE);
//      ShowMessage(GetEnvironmentVariable('VersaoSO'));

      if Win32Platform = VER_PLATFORM_WIN32_NT then
      begin
         if Win32MajorVersion <= 4 then sSO := 'Windows NT!';
         if (Win32MajorVersion = 5) and (Win32MinorVersion < 1) then sSO := 'Windows 2000';
         if (Win32MajorVersion = 5) and (Win32MinorVersion = 1) then sSO := 'Windows XP';
         if (Win32MajorVersion = 5) and (Win32MinorVersion = 2) then sSO := 'Windows 2003';
         if (Win32MajorVersion = 6) and (Win32MinorVersion = 0) and (VerInfo.wProductType <= VER_NT_WORKSTATION) then sSO := 'Windows Vista';
         if (Win32MajorVersion = 6) and (Win32MinorVersion = 0) and (VerInfo.wProductType > VER_NT_WORKSTATION) then sSO := 'Windows 2008 Server';
         if (Win32MajorVersion = 6) and (Win32MinorVersion = 1) and (VerInfo.wProductType <= VER_NT_WORKSTATION) then sSO := 'Windows 7';
         if (Win32MajorVersion = 6) and (Win32MinorVersion = 1) and (VerInfo.wProductType > VER_NT_WORKSTATION) then sSO := 'Windows 2008 Server R2';
         if (Win32MajorVersion = 6) and (Win32MinorVersion = 2) and (VerInfo.wProductType <= VER_NT_WORKSTATION) then sSO := 'Windows 8';
         if (Win32MajorVersion = 6) and (Win32MinorVersion = 2) and (VerInfo.wProductType > VER_NT_WORKSTATION) then sSO := 'Windows 2012 Server';
         if (Win32MajorVersion = 6) and (Win32MinorVersion = 3) and (VerInfo.wProductType <= VER_NT_WORKSTATION) then sSO := 'Windows 8.1';
         if (Win32MajorVersion = 6) and (Win32MinorVersion = 3) and (VerInfo.wProductType > VER_NT_WORKSTATION) then sSO := 'Windows 2012 Server R2';
         if (Win32MajorVersion = 10) and (Win32MinorVersion = 0) and (VerInfo.wProductType <= VER_NT_WORKSTATION) then sSO := 'Windows 10';
         if (Win32MajorVersion = 10) and (Win32MinorVersion = 0) and (VerInfo.wProductType > VER_NT_WORKSTATION) then sSO := 'Windows 2016 Technical Preview';
         sSO := sSO+#13+
                'dwOSVersionInfoSize: '+VerInfo.dwOSVersionInfoSize.ToString+#13+
                'dwMajorVersion     : '+VerInfo.dwMajorVersion.ToString+#13+
                'dwMinorVersion     : '+VerInfo.dwMinorVersion.ToString+#13+
                'dwBuildNumber      : '+VerInfo.dwBuildNumber.ToString+#13+
                'dwPlatformId       : '+VerInfo.dwPlatformId.ToString+#13+
                'szCSDVersion       : '+VerInfo.szCSDVersion+#13+
                'wServicePackMajor  : '+VerInfo.wServicePackMajor.ToString+#13+
                'wServicePackMinor  : '+VerInfo.wServicePackMinor.ToString+#13+
                'wSuiteMask         : '+VerInfo.wSuiteMask.ToString;
      end;
      if Win32Platform = VER_PLATFORM_WIN32_WINDOWS then
      begin
         if (Win32MajorVersion = 4) and (Win32MinorVersion < 1) then sSO := 'Windows 95';
         if (Win32MajorVersion = 4) and (Win32MinorVersion = 1) and (Win32BuildNumber = 1998) then sSO := 'Windows 98';
         if (Win32MajorVersion = 4) and (Win32MinorVersion = 1) and (Win32BuildNumber = 2222) then sSO := 'Windows 98SE';
         if (Win32MajorVersion = 4) and (Win32MinorVersion = 90) then sSO := 'Windows Me';
      end;

      ZeroMemory(@SysInfo, SizeOf(SysInfo));
//      if sSO <> 'Windows 2000' then // GetNativeSystemInfo não é suportada no Windows 2000
//         GetNativeSystemInfo(SysInfo);
         GetSystemInfo(SysInfo);

      try sSP := IntToStr(VerInfo.wServicePackMajor)+'.'+IntToStr(VerInfo.wServicePackMinor); except end;
      if sSP = '0.0' then sSP := '';

      sMais := #13#13+
      'dwActiveProcessorMask..: '+IntToStr(SysInfo.dwActiveProcessorMask)+#13+
      'dwOemId................: '+SysInfo.dwOemId.ToString+#13+
      'wReserved..............: '+SysInfo.wReserved.ToString+#13+
      'dwPageSize.............: '+SysInfo.dwPageSize.ToString+#13+
      'dwNumberOfProcessors...: '+SysInfo.dwNumberOfProcessors.ToString+#13+
      'dwProcessorType........: '+SysInfo.dwProcessorType.ToString+#13+
      'dwAllocationGranularity: '+SysInfo.dwAllocationGranularity.ToString+#13+
      'wProcessorLevel........: '+SysInfo.wProcessorLevel.ToString+#13+
      'wProcessorRevision.....: '+SysInfo.wProcessorRevision.ToString;

      lbV.Caption := sSO+#13+'Plataforma..: '+IntToStr(Win32Platform)+
                         #13+'Tipo Produto: '+TipoProduto[VerInfo.wProductType]+
                         #13+'Arquitetura.: '+Arquitetura(TOSVersion.Architecture)+
                         #13+'Versão......: '+IntToStr(Win32MajorVersion)+'.'+IntToStr(Win32MinorVersion)+'.'+IntToStr(Win32BuildNumber)+
                         IfThen(sSP <> '',#13+'Service Pack: '+sSP,'')+
                         IfThen(Win32CSDVersion <> '',#13+Win32CSDVersion,'')+
                         sMais;
      Clipboard.AsText := lbV.Caption;

//      GetVersion.ToString;
//      GetFileVersion(ParamStr(0)).ToString;
      iAMajor := GetFileVersion(ParamStr(0)) div 65536;
      sAMajor := iAMajor.ToString;
      sAMinor := (GetFileVersion(ParamStr(0))-(iAMajor*65536)).ToString;
//      sABuild
      GetProductVersion(ParamStr(0),iAMajor,iAMinor,iABuild);
      StatusBar1.Panels[0].Text := iAMajor.ToString+'.'+iAMinor.ToString+'.'+iABuild.ToString+'  -  '+sAMajor+'.'+sAMinor;
//      ShowMessage(TLanguages.UserDefaultLocale.ToString);
//      ShowMessage(TLanguages.GetLocaleIDFromLocaleName('pt_br').ToString);
//      ShowMessage(FormatSettings.LongMonthNames[MonthOf(Date)]);
   {$ENDIF}
   {$IFDEF LINUX}
   {$ENDIF}
{
Windows 8
Plataforma..: 2Tipo Produto: WORKSTATIONArquitetura.: Intel x86Versão......: 6.2.9200dwActiveProcessorMask..: 15dwOemId................: 0wReserved..............: 0dwPageSize.............: 4096dwNumberOfProcessors...: 4dwProcessorType........: 586dwAllocationGranularity: 65536wProcessorLevel........: 6wProcessorRevision.....: 3851
}
end;

end.
