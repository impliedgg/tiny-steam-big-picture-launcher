@echo off
rem tiny-steam-big-picture-launcher uninstall.bat
rem mit license. tl;dr im not responsible if you break shit

rem run as admin if we're not admin
net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    powershell Start-Process -FilePath '%0' -ArgumentList "%cd%" -verb runas >NUL 2>&1
    exit /b
)
if %1!=="" cd /d %1

if exist "C:\BigPicture.exe" del "C:\BigPicture.exe" > nul
FOR /F "delims=" %%I IN ('cmd /c reg query "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "Shell" 2^> NUL') DO @SET "reg_output=%%I"
if "%reg_output%"=="    Shell    REG_SZ    C:\BigPicture.exe" reg delete "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "Shell" /f > nul

echo uninstalled big picture mode wrapper. log out and log in again to fully apply changes.
set reg_output=
echo press enter to exit...
pause > NUL 2> NUL
exit