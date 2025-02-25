@echo off
title TCB's Anti-Virus

:mainMenu
echo.
echo TCB's Anti-Virus
echo ------------------
echo 1. Vulnerability Scan
echo 2. Malware Scan
echo 3. System Information
echo 4. Network Connections
echo 5. Startup Programs
echo 6. Running Processes
echo 7. Disk Space Check
echo 8. Firewall Status
echo 9. User Accounts
echo 10. Event Logs (Basic)
echo 11. Clear Temp Files
echo 12. List Installed Software
echo 13. Basic Registry Scan (Suspicious Keys)
echo 14. IP Configuration
echo 15. Exit
echo.
set /p choice=Enter your choice:

if %choice%==1 goto vulnScan
if %choice%==2 goto malwareScan
if %choice%==3 goto sysInfo
if %choice%==4 goto netConnections
if %choice%==5 goto startupPrograms
if %choice%==6 goto runningProcesses
if %choice%==7 goto diskSpace
if %choice%==8 goto firewallStatus
if %choice%==9 goto userAccounts
if %choice%==10 goto eventLogs
if %choice%==11 goto clearTemp
if %choice%==12 goto installedSoftware
if %choice%==13 goto registryScan
if %choice%==14 goto ipConfig
if %choice%==15 goto exit

echo Invalid choice. Please try again.
pause
goto mainMenu

:vulnScan
echo.
echo Vulnerability Scan...
echo ---------------------

echo Checking for open ports...
netstat -ano | findstr : > open_ports.txt
if exist open_ports.txt (
    echo Open ports found. Check open_ports.txt.
    type open_ports.txt
    del open_ports.txt
) else (
    echo No open ports found.
)

echo Checking for vulnerable services (basic example)...
echo This is a simplified check. Real vuln scans are far more complex.
wmic qfe get Caption,HotFixID,InstalledOn > hotfixes.txt
if exist hotfixes.txt (
    echo Installed hotfixes:
    type hotfixes.txt
    del hotfixes.txt
) else (
    echo Could not retrieve hotfix information.
)

echo.
pause
goto mainMenu

:malwareScan
echo.
echo Malware Scan...
echo --------------

echo Scanning for suspicious files (very basic example)...
echo This is a very rudimentary scan. Real malware scans are far more complex.

for /r %%f in (*.exe *.vbs *.js *.bat *.ps1) do (
    echo Checking %%f...
    findstr /i "suspicious_string1 suspicious_string2" "%%f" > nul
    if %errorlevel%==0 (
        echo Suspicious content found in %%f.
        echo Potential malware: %%f
    )
)

echo.
pause
goto mainMenu

:sysInfo
echo.
echo System Information...
echo --------------------
systeminfo | findstr /i "OS Name OS Version System Manufacturer System Model Processor Total Physical Memory"

echo.
pause
goto mainMenu

:netConnections
echo.
echo Network Connections...
echo ----------------------
netstat -abno

echo.
pause
goto mainMenu

:startupPrograms
echo.
echo Startup Programs...
echo --------------------
wmic startup list full

echo.
pause
goto mainMenu

:runningProcesses
echo.
echo Running Processes...
echo --------------------
tasklist

echo.
pause
goto mainMenu

:diskSpace
echo.
echo Disk Space Check...
echo -------------------
wmic logicaldisk get Caption,FreeSpace,Size

echo.
pause
goto mainMenu

:firewallStatus
echo.
echo Firewall Status...
echo -------------------
netsh advfirewall show allprofiles

echo.
pause
goto mainMenu

:userAccounts
echo.
echo User Accounts...
echo -----------------
net user

echo.
pause
goto mainMenu

:eventLogs
echo.
echo Event Logs (Basic)...
echo --------------------
wevtutil qe Application /c:5 /f:text
wevtutil qe System /c:5 /f:text

echo.
pause
goto mainMenu

:clearTemp
echo.
echo Clearing Temp Files...
echo ----------------------
del /q %temp%\*
del /q C:\Windows\Temp\*
echo Temp files cleared.

echo.
pause
goto mainMenu

:installedSoftware
echo.
echo Installed Software...
echo --------------------
wmic product get name,version

echo.
pause
goto mainMenu

:registryScan
echo.
echo Basic Registry Scan (Suspicious Keys)...
echo ----------------------------------------
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"
reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"

echo.
pause
goto mainMenu

:ipConfig
echo.
echo IP Configuration...
echo ------------------
ipconfig /all

echo.
pause
goto mainMenu

:exit
echo Exiting...
exit
