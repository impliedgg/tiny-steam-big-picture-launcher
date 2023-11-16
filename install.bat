@echo off
rem tiny-steam-big-picture-launcher install.bat
rem mit license. tl;dr im not responsible if you break shit
rem this does not work from source.

rem run as admin if we aren't
net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    powershell Start-Process -FilePath '%0' -ArgumentList "%cd%" -verb runas >NUL 2>&1
    exit /b
) 
rem set workdir if it was passed, otherwise suppress syntax error
if %1!=="" cd /d %1

rem check that our new BigPicture.exe file exists. complain if it doesn't
if not exist "BigPicture.exe" goto no_exe

rem if the shell is set to something besides, warn about that
rem stupid hack to get output; from https://stackoverflow.com/a/108615/10334831
FOR /F "delims=" %%I IN ('cmd /c reg query "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "Shell" 2^> NUL') DO @SET "reg_output=%%I"
rem goto
if "%reg_output%"=="    Shell    REG_SZ    C:\BigPicture.exe" goto :install else if "%reg_output%"=="" goto :install else goto potential_config_issue

:install
rem clean old versions
if exist "C:\BigPicture.exe" ( 
    echo removing old wrapper and updating...
    del "C:\BigPicture.exe"
) else echo installing wrapper...

copy "BigPicture.exe" "C:\BigPicture.exe" > NUL 2> NUL
if ERRORLEVEL 1 goto copy_file_failed
rem set registry key
reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "Shell" /t REG_SZ /d "C:\BigPicture.exe" /f > NUL 2> NUL
if ERRORLEVEL 1 goto registry_write_failed
echo installed the big picture wrapper. log out of windows and log back in to see it work.
goto bye

:no_exe
color 4
echo !! ERROR !!
color
echo you did not extract the zip file correctly. drag the tsbpl-release folder to your desktop and run it from there.
goto bye

:potential_config_issue
color 6
echo !! WARNING !!
color
echo you have a custom desktop shell that wasn't set by this installer. this was most likely your doing.
color 6
echo press ctrl-c to cancel the install, or press enter to continue...
color
pause > NUL 2> NUL
goto :install

:copy_file_failed
color 4
echo !! ERROR !!
color
echo copying the new file failed. likely a permissions issue with c:\. you're on your own.
goto bye

:registry_write_failed
color 4
echo !! ERROR !!
color
echo writing to the registry for your shell failed, your windows install may be broken or configured too strictly.
goto bye

:bye
rem cleanup
set reg_output=
echo press enter to exit...
pause > NUL 2> NUL
exit