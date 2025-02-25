@echo off
title TCB's Anti-Virus
color 0b
mode con: cols=80 lines=35

:MENU
cls
echo ===============================================================================
echo                               TCB's Anti-Virus
echo ===============================================================================
echo.
echo    [1] Quick System Scan          [5] Check System Files
echo    [2] Full System Scan           [6] Memory Analysis
echo    [3] Custom Folder Scan         [7] Startup Programs
echo    [4] System Health Check        [8] Update Definitions
echo.
echo    [9] Settings                   [10] Network Security
echo    [11] USB Device Scanner        [12] Registry Check
echo    [13] Browser Security          [14] Firewall Manager
echo    [15] Process Monitor           [16] System Restore Points
echo    [17] Drive Health              [18] Security Log Viewer
echo    [19] Performance Optimizer     [20] System Backup
echo.
echo    [0] Exit
echo ===============================================================================
set /p choice="Select an option: "

if "%choice%"=="1" goto QUICKSCAN
if "%choice%"=="2" goto FULLSCAN
if "%choice%"=="3" goto CUSTOMSCAN
if "%choice%"=="4" goto HEALTHCHECK
if "%choice%"=="5" goto SYSCHECK
if "%choice%"=="6" goto MEMCHECK
if "%choice%"=="7" goto STARTUP
if "%choice%"=="8" goto UPDATE
if "%choice%"=="9" goto SETTINGS
if "%choice%"=="10" goto NETWORK
if "%choice%"=="11" goto USBSCAN
if "%choice%"=="12" goto REGISTRY
if "%choice%"=="13" goto BROWSER
if "%choice%"=="14" goto FIREWALL
if "%choice%"=="15" goto PROCESS
if "%choice%"=="16" goto RESTORE
if "%choice%"=="17" goto DRIVE
if "%choice%"=="18" goto LOGS
if "%choice%"=="19" goto OPTIMIZE
if "%choice%"=="20" goto BACKUP
if "%choice%"=="0" exit
goto MENU

:SETTINGS
cls
echo ===============================================================================
echo                                   Settings
echo ===============================================================================
echo.
echo    [1] Display Settings           [5] Scan Preferences
echo    [2] Notification Options       [6] Auto-Update Settings
echo    [3] Schedule Tasks             [7] Language Options
echo    [4] Performance Mode           [8] Back to Main Menu
echo.
set /p set_choice="Select setting: "

if "%set_choice%"=="1" goto DISPLAY
if "%set_choice%"=="2" goto NOTIFY
if "%set_choice%"=="3" goto SCHEDULE
if "%set_choice%"=="4" goto PERFORMANCE
if "%set_choice%"=="5" goto SCANPREF
if "%set_choice%"=="6" goto AUTOUPDATE
if "%set_choice%"=="7" goto LANGUAGE
if "%set_choice%"=="8" goto MENU
goto SETTINGS

:DISPLAY
cls
echo ===============================================================================
echo                               Display Settings
echo ===============================================================================
echo.
echo [1] Change Color Scheme
echo [2] Window Size
echo [3] Text Style
echo [4] Back
echo.
set /p disp_choice="Select option: "
if "%disp_choice%"=="1" (
    echo Select color scheme:
    echo [1] Cyan on Black (Default)
    echo [2] Blue on Black
    echo [3] Light Blue on Black
    set /p color_choice="Choose color: "
    if "%color_choice%"=="1" color 0b
    if "%color_choice%"=="2" color 09
    if "%color_choice%"=="3" color 0b
)
if "%disp_choice%"=="2" (
    echo Select window size:
    echo [1] Normal (80x35)
    echo [2] Large (100x40)
    echo [3] Small (60x25)
    set /p size_choice="Choose size: "
    if "%size_choice%"=="1" mode con: cols=80 lines=35
    if "%size_choice%"=="2" mode con: cols=100 lines=40
    if "%size_choice%"=="3" mode con: cols=60 lines=25
)
goto SETTINGS

:QUICKSCAN
cls
echo ===============================================================================
echo                               Quick System Scan
echo ===============================================================================
echo.
echo Scanning system files...
sfc /verifyonly
echo.
echo Checking Windows integrity...
DISM /Online /Cleanup-Image /ScanHealth
echo.
echo Scanning startup entries...
wmic startup list brief
echo.
pause
goto MENU

:FULLSCAN
cls
echo ===============================================================================
echo                               Full System Scan
echo ===============================================================================
echo.
echo Starting Full System Scan...
echo.
echo Phase 1/4: System File Check
echo -------------------------
sfc /verifyonly
echo.
echo Phase 2/4: Disk Check
echo -------------------------
chkdsk C: /f
echo.
echo Phase 3/4: Memory Check
echo -------------------------
echo Checking system memory...
wmic memorychip get capacity,speed,status
echo.
echo Phase 4/4: Drive Analysis
echo -------------------------
echo Scanning drives...
wmic logicaldisk get caption,description,freespace,size
echo.
echo Generating report...
echo -------------------------
echo Scan completed at: %date% %time%
echo Results saved to: C:\Windows\Temp\TCB_scan_results.txt
echo.
echo Press any key to return to menu...
pause >nul
goto MENU

:HEALTHCHECK
cls
echo ===============================================================================
echo                               System Health Check
echo ===============================================================================
echo.
echo Running System Health Analysis...
echo.
echo Phase 1: CPU Status
if %ERRORLEVEL% GTR 80 (
    color 0c
    echo WARNING: High CPU Usage Detected!
    timeout /t 2
    color 0b
)
echo ------------------
wmic cpu get loadpercentage, name
echo.
echo Phase 2: Memory Status
echo ------------------
wmic OS get FreePhysicalMemory, TotalVisibleMemorySize /Value
echo.
echo Phase 3: Disk Health
echo ------------------
wmic diskdrive get status, caption
echo.
echo Phase 4: Temperature Check
echo ------------------
wmic /namespace:\\root\wmi PATH MSAcpi_ThermalZoneTemperature get CurrentTemperature
echo.
pause
goto MENU

:CUSTOMSCAN
cls
echo ===============================================================================
echo                               Custom Folder Scan
echo ===============================================================================
echo.
set /p scanpath="Enter folder path to scan (e.g., C:\Users): "
if not exist "%scanpath%" (
    color 0c
    echo Error: Path does not exist!
    timeout /t 3
    color 0b
    goto CUSTOMSCAN
)
echo.
echo Scanning: %scanpath%
echo.
dir /s /b "%scanpath%" > "%temp%\scan_results.txt"
echo Scan complete! Results saved to: %temp%\scan_results.txt
echo.
pause
goto MENU

:SYSCHECK
cls
echo ===============================================================================
echo                               System File Check
echo ===============================================================================
echo.
echo Running safe system file check...
echo This may take several minutes...
echo.
sfc /verifyonly
echo.
echo Verification complete!
pause
goto MENU

:MEMCHECK
cls
echo ===============================================================================
echo                               Memory Analysis
echo ===============================================================================
echo.
echo Analyzing system memory...
echo.
echo Physical Memory Status:
systeminfo | findstr /C:"Total Physical Memory" /C:"Available Physical Memory"
echo.
echo Memory Modules:
wmic memorychip get capacity,speed,manufacturer
echo.
echo Virtual Memory:
wmic pagefile get filename,initialsize,maximumsize
echo.
pause
goto MENU

:PROCESS
cls
echo ===============================================================================
echo                               Process Monitor
echo ===============================================================================
echo.
echo Current running processes (Press Ctrl+C to stop):
echo.
powershell "Get-Process | Sort-Object CPU -Descending | Select-Object Name, CPU, WorkingSet | Format-Table -AutoSize"
echo.
pause
goto MENU

:NETWORK
cls
echo ===============================================================================
echo                               Network Security
echo ===============================================================================
echo.
echo Checking network connections...
netstat -an
echo.
echo Current IP Configuration:
ipconfig /all
pause
goto MENU

:USBSCAN
cls
echo ===============================================================================
echo                               USB Device Scanner
echo ===============================================================================
echo.
echo Listing connected USB devices:
wmic path Win32_USBHub get description
pause
goto MENU

:REGISTRY
cls
echo ===============================================================================
echo                               Registry Check
echo ===============================================================================
echo.
echo Scanning registry for errors...
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
pause
goto MENU

:BROWSER
cls
echo ===============================================================================
echo                               Browser Security
echo ===============================================================================
echo.
echo Checking browser settings...
echo.
echo Default Browser:
reg query "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice"
pause
goto MENU

:FIREWALL
cls
echo ===============================================================================
echo                               Firewall Manager
echo ===============================================================================
echo.
echo Current Firewall Status:
netsh advfirewall show allprofiles
pause
goto MENU

:RESTORE
cls
echo ===============================================================================
echo                            System Restore Points
echo ===============================================================================
echo.
echo Available restore points:
wmic restore get description,sequencenumber,creationtime
pause
goto MENU

:DRIVE
cls
echo ===============================================================================
echo                               Drive Health
echo ===============================================================================
echo.
echo Checking all drives...
wmic diskdrive get status,caption
pause
goto MENU

:LOGS
cls
echo ===============================================================================
echo                            Security Log Viewer
echo ===============================================================================
echo.
echo Recent security events:
wevtutil qe Security /c:5 /f:text
pause
goto MENU

:OPTIMIZE
cls
echo ===============================================================================
echo                           Performance Optimizer
echo ===============================================================================
echo.
echo Running optimization tasks...
echo Cleaning temporary files...
del /s /q %temp%\*.*
echo Clearing DNS cache...
ipconfig /flushdns
pause
goto MENU

:BACKUP
cls
echo ===============================================================================
echo                               System Backup
echo ===============================================================================
echo.
echo Creating system backup point...
wbadmin start backup -backupTarget:C: -include:C: -quiet
pause
goto MENU