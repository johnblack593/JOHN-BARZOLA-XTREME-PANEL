<# :
@echo off
:: =========================================================
:: JOHN BARZOLA XTREME PANEL - HYBRID BOOTLOADER v12
:: =========================================================
setlocal
cd /d %~dp0
title Loading Cyber-Core...

:: Verificacion Admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [SYSTEM] Requesting Elevation...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -Verb RunAs -FilePath '%~f0'"
    exit /b
)

:: Lanzar PowerShell usando este mismo archivo como origen
powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-Expression ($(Get-Content '%~f0' | Out-String))"
exit /b
#>

# =========================================================
# INICIO DEL CODIGO POWERSHELL (CYBER-CORE v12.0)
# =========================================================

$Host.UI.RawUI.WindowTitle = "JOHN BARZOLA XTREME PANEL v12.0 [CYBER-CORE]"
$Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

# --- COLORES ---
$cCyan = "Cyan"
$cGreen = "Green"
$cRed = "Red"
$cYellow = "Yellow"
$cWhite = "White"
$cGray = "DarkGray"
$cMag = "Magenta"

# --- FUNCIONES DE UI ---

function Print-Line {
    Write-Host "   ____________________________________________________________________________________" -ForegroundColor $cGray
    Write-Host ""
}

function Print-Title {
    param([string]$Title)
    Clear-Host
    Write-Host ""
    Write-Host "   // $Title" -ForegroundColor $cCyan -BackgroundColor Black
    Print-Line
}

function Loading-Bar {
    param([string]$Message)
    Write-Host "   > $Message" -NoNewline -ForegroundColor $cGray
    $load = ""
    for($i=0; $i -lt 15; $i++) {
        Start-Sleep -Milliseconds 100
        $load += "█"
        Write-Host "█" -NoNewline -ForegroundColor $cGreen
    }
    Write-Host " [OK]" -ForegroundColor $cWhite
}

# --- LOGIN SYSTEM ---
function Show-Login {
    Clear-Host
    Write-Host ""
    Write-Host "   ======================================================" -ForegroundColor $cCyan
    Write-Host "    SECURE TERMINAL ACCESS // AUTHENTICATION REQUIRED" -ForegroundColor $cWhite
    Write-Host "   ======================================================" -ForegroundColor $cCyan
    Write-Host ""
    Write-Host "   USER: " -NoNewline -ForegroundColor $cGray
    Write-Host "$env:USERNAME" -ForegroundColor $cGreen
    Write-Host ""
    
    $pass = Read-Host -Prompt "   > ENTER PASSPHRASE" -AsSecureString
    $passPlain = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pass)))

    # Bypass de validacion para entorno de pruebas (o activar logica real abajo)
    if ($true) { 
       # if ($passPlain -eq "00199500") ...
       Loading-Bar "Decrypting Environment..."
       Start-Sleep -Seconds 1
       Show-Menu
    }
}

# --- MENU PRINCIPAL ---
function Show-Menu {
    while ($true) {
        Print-Title "MAIN DASHBOARD // SYSTEM ROOT"
        
        Write-Host "   [ EXTERNAL TOOLS ]" -ForegroundColor $cYellow
        Write-Host "   1. Chris Titus WinUtil" -ForegroundColor $cWhite
        Write-Host "      (Tweaks, Debloat & Optimization)" -ForegroundColor $cGray
        Write-Host "   2. IT-Tea Tool" -ForegroundColor $cWhite
        Write-Host "      (Lightweight Cleaner)" -ForegroundColor $cGray
        Write-Host "   3. Microsoft Activation (MAS)" -ForegroundColor $cWhite
        Write-Host "      (HWID Activation)" -ForegroundColor $cGray
        Write-Host ""
        
        Write-Host "   [ SYSTEM MAINTENANCE ]" -ForegroundColor $cYellow
        Write-Host "   4. Deep Repair Protocol" -ForegroundColor $cWhite
        Write-Host "      (DISM + SFC + Drivers Clean)" -ForegroundColor $cGray
        Write-Host "   5. Network Doctor" -ForegroundColor $cWhite
        Write-Host "      (Reset IP, DNS & Winsock)" -ForegroundColor $cGray
        Write-Host ""
        
        Write-Host "   [ SOFTWARE HUB ]" -ForegroundColor $cYellow
        Write-Host "   6. Winget Application Manager" -ForegroundColor $cWhite
        Write-Host "      (Essential Apps, Gaming Libs & Developer Tools)" -ForegroundColor $cGray
        Write-Host ""
        
        Write-Host "   0. EXIT TERMINAL" -ForegroundColor $cRed
        Print-Line
        
        $choice = Read-Host "   root@barzola_sys:~$"
        
        switch ($choice) {
            "1" { Run-Titus }
            "2" { Run-ITTea }
            "3" { Run-MAS }
            "4" { Run-DeepClean }
            "5" { Run-NetFix }
            "6" { Menu-Winget }
            "0" { exit }
            default { Write-Host "   [!] Command not recognized." -ForegroundColor $cRed; Start-Sleep 1 }
        }
    }
}

# --- LOGICA DE MODULOS ---

function Run-Titus {
    Print-Title "LAUNCHING EXTERNAL MODULE"
    Write-Host "   > Initializing Chris Titus Tech WinUtil..." -ForegroundColor $cCyan
    irm "https://christitus.com/win" | iex
}

function Run-ITTea {
    Print-Title "LAUNCHING EXTERNAL MODULE"
    Write-Host "   > Initializing IT-Tea..." -ForegroundColor $cCyan
    irm raw.githubusercontent.com/emadadeldev/ittea/main/itt.ps1 | iex
}

function Run-MAS {
    Print-Title "LAUNCHING EXTERNAL MODULE"
    Write-Host "   > Initializing MAS..." -ForegroundColor $cCyan
    irm https://get.activated.win | iex
}

function Run-DeepClean {
    Print-Title "DEEP REPAIR PROTOCOL"
    
    Write-Host "   [STEP 1/5] Cleaning Driver Repository..." -ForegroundColor $cYellow
    Start-Process -FilePath "rundll32.exe" -ArgumentList "pnpclean.dll,RunDLL_PnpClean /drivers/maxclean" -Wait
    Write-Host "   [DONE]" -ForegroundColor $cGreen
    
    Write-Host "   [STEP 2/5] Checking Image Health..." -ForegroundColor $cYellow
    dism /Online /Cleanup-Image /CheckHealth
    
    Write-Host "   [STEP 3/5] Scanning System Files (SFC)..." -ForegroundColor $cYellow
    sfc /scannow
    
    Write-Host "   [STEP 4/5] Restoring Image Health..." -ForegroundColor $cYellow
    dism /Online /Cleanup-Image /RestoreHealth
    
    Write-Host "   [STEP 5/5] Component Cleanup & ResetBase..." -ForegroundColor $cYellow
    dism /online /Cleanup-Image /Startcomponentcleanup /resetbase
    
    Write-Host ""
    Write-Host "   [SUCCESS] Maintenance Protocol Completed." -ForegroundColor $cGreen
    Read-Host "   Press Enter to return..."
}

function Run-NetFix {
    Print-Title "NETWORK DOCTOR"
    Write-Host "   > Flushing DNS Cache..." -ForegroundColor $cCyan
    ipconfig /flushdns
    Write-Host "   > Resetting Winsock Catalog..." -ForegroundColor $cCyan
    netsh winsock reset
    Write-Host "   > Resetting TCP/IP Stack..." -ForegroundColor $cCyan
    netsh int ip reset
    Write-Host ""
    Write-Host "   [DONE] Network Interface Reset." -ForegroundColor $cGreen
    Read-Host "   Press Enter to return..."
}

# --- MENU WINGET ---
function Menu-Winget {
    while($true) {
        Print-Title "WINGET APPLICATION HUB"
        Write-Host "   1. Essential Pack + GAMING LIBS" -ForegroundColor $cWhite
        Write-Host "      (Chrome, Firefox, VLC, AIMP, qBittorrent, DirectX, XNA, VC++ All)" -ForegroundColor $cGray
        Write-Host ""
        Write-Host "   2. LTSC Recovery (Advanced)" -ForegroundColor $cWhite
        Write-Host "      (Store Recovery, Service Check & Media Player)" -ForegroundColor $cGray
        Write-Host ""
        Write-Host "   3. Developer Tools" -ForegroundColor $cWhite
        Write-Host "      (Select Languages, IDEs, DBs manually)" -ForegroundColor $cGray
        Write-Host ""
        Write-Host "   0. Back to Main Menu" -ForegroundColor $cRed
        Print-Line
        
        $wop = Read-Host "   root@barzola_apps:~$"
        
        if ($wop -eq "0") { break }
        if ($wop -eq "1") { Install-Essentials }
        if ($wop -eq "2") { Install-LTSC }
        if ($wop -eq "3") { Install-Devs }
    }
}

function Install-Winget {
    param($Id, $Name)
    Write-Host "   > Installing Winget Pkg: $Name..." -ForegroundColor $cCyan
    winget install -e --id $Id --accept-package-agreements --accept-source-agreements
}

function Install-Essentials {
    Print-Title "DEPLOYING ESSENTIALS & LIBRARIES"
    
    Write-Host "   [ APPS & MULTIMEDIA ]" -ForegroundColor $cMag
    Install-Winget "Google.Chrome" "Chrome"
    Install-Winget "Mozilla.Firefox" "Firefox"
    Install-Winget "VideoLAN.VLC" "VLC"
    Install-Winget "AIMP.AIMP" "AIMP"
    Install-Winget "qBittorrent.qBittorrent" "qBittorrent (Official)" 
    # OpenAL Eliminado
    
    Write-Host ""
    Write-Host "   [ GAMING RUNTIMES & FRAMEWORKS ]" -ForegroundColor $cMag
    Install-Winget "Microsoft.DirectX" "DirectX End-User Runtime"
    Install-Winget "Microsoft.XNARedist" "Microsoft XNA Framework"
    Install-Winget "Microsoft.DotNet.DesktopRuntime.8" ".NET Desktop Runtime 8"
    
    Write-Host ""
    Write-Host "   [ VISUAL C++ REDISTRIBUTABLES (FULL SUITE) ]" -ForegroundColor $cMag
    Install-Winget "Microsoft.VCRedist.2005.x64" "Visual C++ 2005"
    Install-Winget "Microsoft.VCRedist.2008.x64" "Visual C++ 2008"
    Install-Winget "Microsoft.VCRedist.2010.x64" "Visual C++ 2010"
    Install-Winget "Microsoft.VCRedist.2012.x64" "Visual C++ 2012"
    Install-Winget "Microsoft.VCRedist.2013.x64" "Visual C++ 2013"
    Install-Winget "Microsoft.VCRedist.2015+.x64" "Visual C++ 2015-2022 (AIO)"
    
    Write-Host ""
    Write-Host "   [DONE] All Essentials & Libraries Deployed." -ForegroundColor $cGreen
    Read-Host "   Press Enter..."
}

function Install-LTSC {
    Print-Title "LTSC RECOVERY PROTOCOL"
    
    # 1. Verificacion de Servicios
    Write-Host "   > DIAGNOSTIC: Checking Core Services..." -ForegroundColor $cYellow
    $reqServices = "wuauserv", "AppXSvc", "ClipSVC"
    
    foreach ($srv in $reqServices) {
        $sStatus = Get-Service -Name $srv -ErrorAction SilentlyContinue
        if ($sStatus.Status -ne 'Running') {
             Write-Host "     [FIX] Starting Service: $srv..." -ForegroundColor $cRed
             Set-Service -Name $srv -StartupType Manual -ErrorAction SilentlyContinue
             Start-Service -Name $srv -ErrorAction SilentlyContinue
        } else {
             Write-Host "     [OK] Service Running: $srv" -ForegroundColor $cGreen
        }
    }
    Write-Host ""

    # 2. Instalacion Tienda
    Write-Host "   > EXECUTING STORE RECOVERY (STAGE 1)..." -ForegroundColor $cCyan
    Write-Host "     This process runs in background. Please Wait ~2 Minutes." -ForegroundColor $cGray
    
    wsreset -i
    
    # Barra de progreso simulada para mantener al usuario esperando
    for($i=0; $i -lt 60; $i++) {
        Write-Host "." -NoNewline -ForegroundColor $cGreen
        Start-Sleep -Seconds 2
    }
    Write-Host ""
    
    # 3. Validacion
    if (Test-Path "$env:ProgramFiles\WindowsApps\Microsoft.WindowsStore*") {
        Write-Host "   [SUCCESS] Microsoft Store detected." -ForegroundColor $cGreen
    } else {
        Write-Host "   [WARNING] Store not found yet. Retrying (STAGE 2)..." -ForegroundColor $cRed
        wsreset -i
        Write-Host "     Waiting 30s more..." -ForegroundColor $cGray
        Start-Sleep -Seconds 30
        
        if (Test-Path "$env:ProgramFiles\WindowsApps\Microsoft.WindowsStore*") {
            Write-Host "   [SUCCESS] Microsoft Store detected on Retry." -ForegroundColor $cGreen
        } else {
            Write-Host "   [ERROR] Store failed to install. Check Internet/Updates." -ForegroundColor $cRed
        }
    }
    
    # 4. Windows Media Player
    Write-Host ""
    Write-Host "   > ENABLING WINDOWS MEDIA PLAYER..." -ForegroundColor $cYellow
    dism /online /enable-feature /featurename:WindowsMediaPlayer /all
    
    Write-Host ""
    Write-Host "   [DONE] Recovery Protocol Finished." -ForegroundColor $cGreen
    Read-Host "   Press Enter..."
}

function Install-Devs {
    Print-Title "DEVELOPER TOOLKIT"
    Write-Host "   Select IDs separated by SPACE (Example: 1 6 12)" -ForegroundColor $cYellow
    Write-Host ""
    Write-Host "   [LANGUAGES]           [IDE / EDITORS]" -ForegroundColor $cCyan
    Write-Host "   1. Python 3           6. VS Code"
    Write-Host "   2. Node.js (LTS)      7. Windsurf IDE"
    Write-Host "   3. Go Lang            8. Google Antigravity"
    Write-Host "   4. PHP"
    Write-Host "   5. Java JDK 21"
    Write-Host ""
    Write-Host "   [TOOLS / DB]          [WEB / BROWSERS]" -ForegroundColor $cCyan
    Write-Host "   9. Docker Desktop     13. Comet Browser"
    Write-Host "   10. Postman           14. Angular CLI"
    Write-Host "   11. Git"
    Write-Host "   12. MySQL Workbench"
    Write-Host ""
    
    $sel = Read-Host "   root@barzola_dev:~$"
    $items = $sel -split " "
    
    foreach ($i in $items) {
        switch ($i) {
            "1" { Install-Winget "Python.Python.3" "Python 3" }
            "2" { Install-Winget "OpenJS.NodeJS" "Node.js" }
            "3" { Install-Winget "GoLang.Go" "Go Lang" }
            "4" { Install-Winget "PHP.PHP" "PHP" }
            "5" { Install-Winget "Oracle.JDK.21" "Java JDK" }
            "6" { Install-Winget "Microsoft.VisualStudioCode" "VS Code" }
            "7" { Install-Winget "Codeium.Windsurf" "Windsurf IDE" }
            "8" { Install-Winget "Google.Antigravity" "Google Antigravity" }
            "9" { Install-Winget "Docker.DockerDesktop" "Docker" }
            "10" { Install-Winget "Postman.Postman" "Postman" }
            "11" { Install-Winget "Git.Git" "Git" }
            "12" { Install-Winget "Oracle.MySQLWorkbench" "MySQL Workbench" }
            # WinSCP Eliminado
            "13" { Install-Winget "Perplexity.Comet" "Comet Browser" }
            "14" { 
                Write-Host "   > Installing Angular CLI (npm)..." -ForegroundColor $cCyan
                cmd /c "npm install -g @angular/cli" 
            }
        }
    }
    Write-Host "   [DONE] Selected tools installed." -ForegroundColor $cGreen
    Read-Host "   Press Enter..."
}

# --- ARRANQUE ---
# Verificacion de clave hardcodeada para demo
function Auth-Sequence {
    Clear-Host
    Write-Host ""
    Write-Host "   ======================================================" -ForegroundColor $cCyan
    Write-Host "    SECURE TERMINAL ACCESS // AUTHENTICATION REQUIRED" -ForegroundColor $cWhite
    Write-Host "   ======================================================" -ForegroundColor $cCyan
    Write-Host "   USER: $env:USERNAME" -ForegroundColor $cGreen
    Write-Host ""
    
    $inputPass = Read-Host -Prompt "   > ENTER PASSPHRASE" -AsSecureString
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($inputPass)
    $Plain = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    
    if ($Plain -eq "00199500") {
        Loading-Bar "Decrypting..."
        Start-Sleep -Seconds 1
        Show-Menu
    } else {
        Write-Host "   [ACCESS DENIED]" -ForegroundColor $cRed
        Start-Sleep 2
        Auth-Sequence
    }
}

Auth-Sequence