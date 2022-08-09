@Echo Off
Setlocal
FSUTIL dirty query %SystemDrive% >nul
if %errorlevel% EQU 0 goto START

   Set _batchFile=%~f0
   Set _Args=%*
   Set _batchFile=""%_batchFile:"=%""
   Set _Args=%_Args:"=""%

   Echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\~ElevateMe.vbs"
   Echo UAC.ShellExecute "cmd", "/c ""%_batchFile% %_Args%""", "", "runas", 1 >> "%temp%\~ElevateMe.vbs"

   cscript "%temp%\~ElevateMe.vbs" 
   Exit /B

:START
cd /d %~dp0
sc stop WinDefend
sc config WinDefend start= disabled

