@echo off
setlocal EnableDelayedExpansion
title PROTON VPN 5-MINUTE ROTATOR (PANKAJ)
cls
echo ==================================================
echo      STARTING AUTOMATIC PROTON VPN ROTATION      
echo      OPERATOR: PANKAJ  ^|  TIER: FREE (RANDOM IP) 
echo ==================================================
echo Leave this window open in the background.
echo.

set "PROTON_PATH="

:: 1. Ask the registry directly -- every installer that follows Windows conventions
::    writes InstallLocation under one of these two Uninstall hives. This is the
::    same mechanism Control Panel > "Apps and Features" uses to list programs.
for %%R in (
    "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall"
    "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
) do (
    if not defined PROTON_PATH (
        for /f "delims=" %%K in ('reg query %%R /s /f "ProtonVPN" /k 2^>nul ^| findstr /i "ProtonVPN"') do (
            for /f "tokens=2,*" %%A in ('reg query "%%K" /v InstallLocation 2^>nul ^| findstr /i "InstallLocation"') do (
                if exist "%%B\ProtonVPN.exe" set "PROTON_PATH=%%B\ProtonVPN.exe"
            )
        )
    )
)

:: 2. Fallback: scan versioned Program Files folder directly
if not defined PROTON_PATH (
    if exist "C:\Program Files\Proton\VPN\" (
        for /d %%i in ("C:\Program Files\Proton\VPN\*") do (
            if exist "%%i\ProtonVPN.exe" set "PROTON_PATH=%%i\ProtonVPN.exe"
        )
    )
)

:: 3. Fallback: legacy x86 install
if not defined PROTON_PATH (
    if exist "C:\Program Files (x86)\Proton Technologies\ProtonVPN\ProtonVPN.exe" set "PROTON_PATH=C:\Program Files (x86)\Proton Technologies\ProtonVPN\ProtonVPN.exe"
)

:: 4. Last resort -- only if registry AND both folder scans failed
if not defined PROTON_PATH (
    echo [ERROR] Registry lookup and folder scans both failed to find ProtonVPN.exe.
    set /p "PROTON_PATH=Paste the FULL path to ProtonVPN.exe here: "
)

if not exist "%PROTON_PATH%" (
    echo [ERROR] That path does not exist: "%PROTON_PATH%"
    pause
    exit /b
)

echo [+] Located target binary at: "%PROTON_PATH%"
echo.

:loop
echo [%time%] Triggering Disconnect...
taskkill /f /im OpenVPN.exe 2>nul
taskkill /f /im wireguard.exe 2>nul
taskkill /f /im ProtonVPN.exe 2>nul
taskkill /f /im ProtonVpnService.exe 2>nul

echo [%time%] Waiting 5 seconds for network adapter to clear...
timeout /t 5 >nul

echo [%time%] Requesting Random Free Quick-Connect...
start "" "%PROTON_PATH%" --connect

echo [+] Rotation complete! Holding this IP for 5 minutes...
timeout /t 300 >nul

goto loop
