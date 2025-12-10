@echo off
:: =========================================================
:: BARZOLA CYBER PANEL - Local Launcher
:: =========================================================
:: This file allows local execution with double-click
:: =========================================================

title Barzola Cyber Panel Launcher
cd /d %~dp0

:: Check for Admin privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [SYSTEM] Requesting Administrator privileges...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -Verb RunAs -FilePath '%~f0'"
    exit /b
)

:: Launch PowerShell script
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0BarzolaCyberPanel.ps1"
pause
