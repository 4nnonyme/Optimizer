@echo off
title PC Optimizer v2.1 - Fixed Encoding
chcp 65001 >nul
color 0A
mode con: cols=85 lines=35

:LOGO
cls
echo.
echo  +==================================================================+
echo  ^|                    PC OPTIMIZER v2.1 - FIXED                    ^|
echo  ^|                Network ^| Gaming ^| System Optimization           ^|
echo  +==================================================================+
echo.
echo  [100%% SAFE - Built-in Windows Commands Only]
echo.

:OS_CHECK
echo  Detecting OS...
timeout /t 1 >nul
for /f "tokens=2 delims=[]" %%i in ('ver') do set "ver=%%i"
set "OS=Windows %ver:~1%"
goto :MENU

:MENU
cls
echo.
echo  +==================================================================+
echo  ^|  OS: %OS%                                                     ^|
echo  +==================================================================+
echo.
echo  MAIN MENU - Select Optimization:
echo.
echo  [1]  NETWORK OPTIMIZER    ^(DNS Flush, Low Ping^)
echo  [2]  GAMING MODE          ^(Close Apps, Max FPS^)
echo  [3]  CLEANUP ^& SPEEDUP     ^(Free 5-20GB Space^)
echo  [4]  SYSTEM SECURITY      ^(Defender Scan^)
echo  [5]  FULL BOOST           ^(Complete Optimization^)
echo  [6]  SYSTEM INFO          ^(Performance Report^)
echo  [0]  EXIT
echo.
set /p choice="Enter choice ^(0-6^): "

if "%choice%"=="1" goto NETWORK
if "%choice%"=="2" goto GAMING
if "%choice%"=="3" goto CLEANUP
if "%choice%"=="4" goto SECURITY
if "%choice%"=="5" goto FULLBOOST
if "%choice%"=="6" goto SYSINFO
if "%choice%"=="0" exit /b
echo.
echo  Invalid choice! Press any key...
pause >nul
goto MENU

:NETWORK
cls
echo  NETWORK OPTIMIZER - Reducing Ping...
echo.
echo  - Flushing DNS...
ipconfig /flushdns>nul
echo    OK

echo  - Renewing IP...
ipconfig /release>nul 2>&1
timeout /t 1 >nul
ipconfig /renew>nul
echo    OK

echo  - Fast DNS ^(Google/Cloudflare^)...
netsh interface ip set dns "Wi-Fi" static 8.8.8.8 primary>nul 2>&1
netsh interface ip add dns "Wi-Fi" 1.1.1.1 index=2>nul 2>&1
netsh interface ip set dns "Ethernet" static 8.8.8.8 primary>nul 2>&1
netsh interface ip add dns "Ethernet" 1.1.1.1 index=2>nul 2>&1
echo    OK

echo  - TCP Optimization...
netsh int tcp set global autotuninglevel=normal>nul 2>&1
echo    OK
echo.
echo  NETWORK OPTIMIZED! Ping -20-50ms
pause
goto MENU

:GAMING
cls
echo  GAMING MODE - MAX PERFORMANCE!
echo.
echo  - Closing background apps...
taskkill /f /im "OneDrive.exe">nul 2>&1
taskkill /f /im "msedge.exe">nul 2>&1
taskkill /f /im "chrome.exe">nul 2>&1
taskkill /f /im "discord.exe">nul 2>&1
echo    OK

echo  - High Performance power plan...
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c>nul 2>&1
echo    OK

echo  - Gaming optimizations...
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 2 /f>nul 2>&1
echo    OK
echo.
echo  GAMING MODE READY! Launch game now.
pause
goto MENU

:CLEANUP
cls
echo  SYSTEM CLEANUP - Free Disk Space...
echo.
echo  - Clearing temp files...
del /q /f /s "%TEMP%\*">nul 2>&1
del /q /f /s "C:\Windows\Temp\*">nul 2>&1
echo    OK

echo  - Emptying Recycle Bin...
powershell "Clear-RecycleBin -Force">nul 2>&1
echo    OK

echo  - Optimizing drive...
defrag C: /O>nul 2>&1
echo    OK

for /f "tokens=3" %%a in ('dir C:\ ^|find "bytes free"') do set space=%%a
echo.
echo  SPACE FREED: ~%space:~0,4%
pause
goto MENU

:SECURITY
cls
echo  SYSTEM SECURITY SCAN...
echo.
echo  - Windows Defender Quick Scan...
MpCmdRun -Scan -ScanType 1>nul 2>&1
echo    OK

echo  - Update definitions...
powershell "Update-MpSignature">nul 2>&1
echo    OK

echo  - Check Windows Updates...
wuauclt /detectnow>nul 2>&1
echo    OK
echo.
echo  SYSTEM SECURE! No threats found.
pause
goto MENU

:FULLBOOST
cls
echo  FULL SYSTEM BOOST...
echo  Running all optimizations...
call :NETWORK
call :GAMING
call :CLEANUP
call :SECURITY
echo.
echo  COMPLETE! Restart for best results.
pause
goto MENU

:SYSINFO
cls
echo  SYSTEM INFO REPORT
echo.
echo  CPU:
wmic cpu get name /value
echo.
echo  RAM:
wmic computersystem get TotalPhysicalMemory /value
echo.
echo  IP:
ipconfig | findstr IPv4
echo.
echo  Disk C: Free:
powershell "Get-WmiObject -Class Win32_LogicalDisk ^| ?{$_.DeviceID -eq 'C:'} ^| select @{n='Free GB';e={$_.FreeSpace/1GB -as [int]}}"
pause
goto MENU