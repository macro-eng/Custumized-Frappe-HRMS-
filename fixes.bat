@echo off
echo ======================================
echo    Windows 10 Fix Tool (Search + Settings)
echo ======================================
echo.

:: تشغيل كمسؤول
NET SESSION >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [!] يجب تشغيل هذا الملف كمسؤول. اضغط Right Click > Run as Administrator
    pause
    exit
)

:: إعادة تشغيل خدمة Windows Search
echo [+] Restarting Windows Search Service...
net stop WSearch
net start WSearch

:: إعادة تسجيل تطبيق البحث
echo [+] Re-registering Windows Search...
powershell -Command "Get-AppXPackage -Name Microsoft.Windows.Search | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register \"$($_.InstallLocation)\AppXManifest.xml\"}"

:: إعادة تسجيل تطبيق الإعدادات
echo [+] Re-registering Settings App...
powershell -Command "Get-AppxPackage *windows.immersivecontrolpanel* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register \"$($_.InstallLocation)\AppXManifest.xml\"}"

:: فحص ملفات النظام
echo [+] Running System File Checker...
sfc /scannow

:: إصلاح ملفات النظام باستخدام DISM
echo [+] Running DISM RestoreHealth...
DISM /Online /Cleanup-Image /RestoreHealth

echo.
echo [✔] Done! Please restart your computer.
pause
