# =========================================================
# JOHN BARZOLA XTREME PANEL - CYBER-CORE v12.0
# GitHub Remote Execution Version
# =========================================================
# Usage: irm https://raw.githubusercontent.com/YOUR_USER/YOUR_REPO/main/BarzolaCyberPanel.ps1 | iex
# =========================================================

#Requires -RunAsAdministrator

# --- CONFIGURACION ---
$script:Version = "12.0"
$script:BuildDate = "2024-12"
$script:Author = "John Barzola"

# --- COLORES ---
$cCyan = "Cyan"
$cGreen = "Green"
$cRed = "Red"
$cYellow = "Yellow"
$cWhite = "White"
$cGray = "DarkGray"
$cMag = "Magenta"

# --- VERIFICACION DE PRIVILEGIOS ---
function Test-Administrator {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Administrator)) {
    Write-Host "`n  [ERROR] Este script requiere privilegios de Administrador." -ForegroundColor $cRed
    Write-Host "  Ejecuta PowerShell como Administrador e intenta de nuevo.`n" -ForegroundColor $cYellow
    Write-Host "  O usa este comando:" -ForegroundColor $cGray
    Write-Host "  Start-Process powershell -Verb RunAs -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command `"irm TU_URL | iex`"'" -ForegroundColor $cWhite
    pause
    exit
}

# --- CONFIGURACION DE VENTANA ---
$Host.UI.RawUI.WindowTitle = "JOHN BARZOLA XTREME PANEL v$script:Version [CYBER-CORE]"
$Host.UI.RawUI.BackgroundColor = "Black"
try { $Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(120, 35) } catch {}
Clear-Host

# --- FUNCIONES DE UI ---

function Write-SeparatorLine {
    Write-Host "   ===================================================================================" -ForegroundColor $cGray
    Write-Host ""
}

function Write-Title {
    param([string]$Title)
    Clear-Host
    Write-Host ""
    Write-Host "   +=====================================================================================+" -ForegroundColor $cCyan
    Write-Host "   |  $Title" -ForegroundColor $cCyan -NoNewline
    $padding = 84 - $Title.Length
    if ($padding -lt 0) { $padding = 0 }
    Write-Host (" " * $padding) -NoNewline
    Write-Host "|" -ForegroundColor $cCyan
    Write-Host "   +=====================================================================================+" -ForegroundColor $cCyan
    Write-Host ""
}

function Show-Banner {
    Clear-Host
    Write-Host ""
    Write-Host "    ____  _   _  ____   _____  ____           ____   ___   ____   _____  " -ForegroundColor $cCyan
    Write-Host "   / ___|| | | ||  _ \ | ____||  _ \         / ___| / _ \ |  _ \ | ____| " -ForegroundColor $cCyan
    Write-Host "  | |    | |_| || |_) ||  _|  | |_) | _____ | |    | | | || |_) ||  _|   " -ForegroundColor $cGreen
    Write-Host "  | |___ |  _  ||  __/ | |___ |  _ < |_____|| |___ | |_| ||  _ < | |___  " -ForegroundColor $cGreen
    Write-Host "   \____||_| |_||_|    |_____||_| \_\        \____| \___/ |_| \_\|_____| " -ForegroundColor $cYellow
    Write-Host ""
    Write-Host "                    +===========================================+" -ForegroundColor $cGray
    Write-Host "                    |   JOHN BARZOLA XTREME PANEL v$script:Version      |" -ForegroundColor $cWhite
    Write-Host "                    |        CYBER-CORE SYSTEM TOOLS            |" -ForegroundColor $cGray
    Write-Host "                    +===========================================+" -ForegroundColor $cGray
    Write-Host ""
}

function Show-LoadingBar {
    param([string]$Message, [int]$Steps = 20)
    Write-Host "   > $Message " -NoNewline -ForegroundColor $cGray
    for ($i = 0; $i -lt $Steps; $i++) {
        Start-Sleep -Milliseconds 50
        Write-Host "#" -NoNewline -ForegroundColor $cGreen
    }
    Write-Host " [OK]" -ForegroundColor $cGreen
}

function Write-Status {
    param([string]$Message, [string]$Status = "INFO")
    switch ($Status) {
        "OK" { $icon = "[OK]"; $col = $cGreen }
        "WARN" { $icon = "[!!]"; $col = $cYellow }
        "ERROR" { $icon = "[XX]"; $col = $cRed }
        "RUN" { $icon = "[>>]"; $col = $cCyan }
        default { $icon = "[--]"; $col = $cWhite }
    }
    Write-Host "   $icon " -NoNewline -ForegroundColor $col
    Write-Host $Message -ForegroundColor $cWhite
}

function Test-InternetConnection {
    try {
        $null = Test-Connection -ComputerName "8.8.8.8" -Count 1 -Quiet -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

# --- MENU PRINCIPAL ---
function Show-Menu {
    while ($true) {
        Show-Banner
        
        # Status Bar
        $isOnline = Test-InternetConnection
        $onlineStatus = if ($isOnline) { "[ONLINE]" } else { "[OFFLINE]" }
        $onlineColor = if ($isOnline) { $cGreen } else { $cRed }
        Write-Host "   +---------------------------------------------------------------------------------+" -ForegroundColor $cGray
        Write-Host "   |  USER: " -NoNewline -ForegroundColor $cGray
        Write-Host "$env:USERNAME" -NoNewline -ForegroundColor $cGreen
        Write-Host "  |  STATUS: " -NoNewline -ForegroundColor $cGray
        Write-Host $onlineStatus -NoNewline -ForegroundColor $onlineColor
        Write-Host "  |  OS: " -NoNewline -ForegroundColor $cGray
        $osCaption = (Get-CimInstance Win32_OperatingSystem).Caption
        Write-Host $osCaption -ForegroundColor $cWhite
        Write-Host "   +---------------------------------------------------------------------------------+" -ForegroundColor $cGray
        Write-Host ""
        
        Write-Host "   [*] EXTERNAL TOOLS" -ForegroundColor $cYellow
        Write-Host "      [1] Chris Titus WinUtil     " -NoNewline -ForegroundColor $cWhite
        Write-Host "(Tweaks, Debloat and Optimization)" -ForegroundColor $cGray
        Write-Host "      [2] IT-Tea Tool             " -NoNewline -ForegroundColor $cWhite
        Write-Host "(Lightweight Cleaner)" -ForegroundColor $cGray
        Write-Host "      [3] Microsoft Activation    " -NoNewline -ForegroundColor $cWhite
        Write-Host "(HWID Activation - MAS)" -ForegroundColor $cGray
        Write-Host ""
        
        Write-Host "   [*] SYSTEM MAINTENANCE" -ForegroundColor $cYellow
        Write-Host "      [4] Deep Repair Protocol    " -NoNewline -ForegroundColor $cWhite
        Write-Host "(DISM + SFC + Drivers Clean)" -ForegroundColor $cGray
        Write-Host "      [5] Network Doctor          " -NoNewline -ForegroundColor $cWhite
        Write-Host "(Reset IP, DNS and Winsock)" -ForegroundColor $cGray
        Write-Host ""
        
        Write-Host "   [*] SOFTWARE HUB" -ForegroundColor $cYellow
        Write-Host "      [6] Winget App Manager      " -NoNewline -ForegroundColor $cWhite
        Write-Host "(Essential Apps, Gaming Libs and Dev Tools)" -ForegroundColor $cGray
        Write-Host ""
        
        Write-Host "   [*] EXTRAS" -ForegroundColor $cYellow
        Write-Host "      [7] Hardware Info           " -NoNewline -ForegroundColor $cWhite
        Write-Host "(CPU, RAM, GPU, Disk Summary)" -ForegroundColor $cGray
        Write-Host ""
        
        Write-SeparatorLine
        Write-Host "      [0] EXIT" -ForegroundColor $cRed
        Write-Host ""
        
        $choice = Read-Host "   root@barzola_sys:~$"
        
        switch ($choice) {
            "1" { Invoke-Titus }
            "2" { Invoke-ITTea }
            "3" { Invoke-MAS }
            "4" { Start-DeepClean }
            "5" { Repair-Network }
            "6" { Show-WingetMenu }
            "7" { Show-HardwareInfo }
            "0" { 
                Write-Host "`n   Goodbye! Stay Secure.`n" -ForegroundColor $cCyan
                exit 
            }
            default { 
                Write-Host "   [!] Command not recognized." -ForegroundColor $cRed
                Start-Sleep 1 
            }
        }
    }
}

# --- MODULOS EXTERNOS ---

function Invoke-Titus {
    Write-Title "CHRIS TITUS WINUTIL"
    if (-not (Test-InternetConnection)) {
        Write-Status "No internet connection detected." "ERROR"
        Read-Host "   Press Enter to return..."
        return
    }
    Write-Status "Initializing Chris Titus Tech WinUtil..." "RUN"
    try {
        Invoke-RestMethod "https://christitus.com/win" | Invoke-Expression
    }
    catch {
        Write-Status "Failed to load WinUtil: $($_.Exception.Message)" "ERROR"
    }
    Read-Host "   Press Enter to return..."
}

function Invoke-ITTea {
    Write-Title "IT-TEA TOOL"
    if (-not (Test-InternetConnection)) {
        Write-Status "No internet connection detected." "ERROR"
        Read-Host "   Press Enter to return..."
        return
    }
    Write-Status "Initializing IT-Tea..." "RUN"
    try {
        Invoke-RestMethod "https://raw.githubusercontent.com/emadadeldev/ittea/main/itt.ps1" | Invoke-Expression
    }
    catch {
        Write-Status "Failed to load IT-Tea: $($_.Exception.Message)" "ERROR"
    }
    Read-Host "   Press Enter to return..."
}

function Invoke-MAS {
    Write-Title "MICROSOFT ACTIVATION SCRIPTS"
    if (-not (Test-InternetConnection)) {
        Write-Status "No internet connection detected." "ERROR"
        Read-Host "   Press Enter to return..."
        return
    }
    Write-Status "Initializing MAS..." "RUN"
    try {
        Invoke-RestMethod https://get.activated.win | Invoke-Expression
    }
    catch {
        Write-Status "Failed to load MAS: $($_.Exception.Message)" "ERROR"
    }
    Read-Host "   Press Enter to return..."
}

# --- MANTENIMIENTO DEL SISTEMA ---

function Start-DeepClean {
    Write-Title "DEEP REPAIR PROTOCOL"
    
    Write-Host ""
    Write-Host "   This will run:" -ForegroundColor $cYellow
    Write-Host "   - Driver Repository Cleanup" -ForegroundColor $cGray
    Write-Host "   - DISM Health Check and Restore" -ForegroundColor $cGray
    Write-Host "   - System File Checker (SFC)" -ForegroundColor $cGray
    Write-Host "   - Component Cleanup" -ForegroundColor $cGray
    Write-Host ""
    
    $confirm = Read-Host "   Continue? (Y/N)"
    if ($confirm -ne "Y" -and $confirm -ne "y") { return }
    
    Write-Host ""
    Write-Status "Cleaning Driver Repository..." "RUN"
    try {
        Start-Process -FilePath "rundll32.exe" -ArgumentList "pnpclean.dll,RunDLL_PnpClean /drivers/maxclean" -Wait -ErrorAction SilentlyContinue
        Write-Status "Driver cleanup completed" "OK"
    }
    catch {
        Write-Status "Driver cleanup skipped" "WARN"
    }
    
    Write-Status "Checking Image Health..." "RUN"
    dism /Online /Cleanup-Image /CheckHealth
    
    Write-Status "Scanning System Files (SFC)..." "RUN"
    sfc /scannow
    
    Write-Status "Restoring Image Health..." "RUN"
    dism /Online /Cleanup-Image /RestoreHealth
    
    Write-Status "Component Cleanup and ResetBase..." "RUN"
    dism /online /Cleanup-Image /Startcomponentcleanup /resetbase
    
    Write-Host ""
    Write-Status "Maintenance Protocol Completed!" "OK"
    Read-Host "   Press Enter to return..."
}

function Repair-Network {
    Write-Title "NETWORK DOCTOR"
    
    Write-Host ""
    Write-Host "   This will reset your network configuration:" -ForegroundColor $cYellow
    Write-Host "   - Flush DNS Cache" -ForegroundColor $cGray
    Write-Host "   - Reset Winsock Catalog" -ForegroundColor $cGray
    Write-Host "   - Reset TCP/IP Stack" -ForegroundColor $cGray
    Write-Host ""
    
    $confirm = Read-Host "   Continue? (Y/N)"
    if ($confirm -ne "Y" -and $confirm -ne "y") { return }
    
    Write-Host ""
    Write-Status "Flushing DNS Cache..." "RUN"
    ipconfig /flushdns | Out-Null
    Write-Status "DNS Cache flushed" "OK"
    
    Write-Status "Resetting Winsock Catalog..." "RUN"
    netsh winsock reset | Out-Null
    Write-Status "Winsock reset completed" "OK"
    
    Write-Status "Resetting TCP/IP Stack..." "RUN"
    netsh int ip reset | Out-Null
    Write-Status "TCP/IP reset completed" "OK"
    
    Write-Host ""
    Write-Status "Network Interface Reset Complete!" "OK"
    Write-Host "   [!] A restart may be required for full effect." -ForegroundColor $cYellow
    Read-Host "   Press Enter to return..."
}

# --- HARDWARE INFO ---
function Show-HardwareInfo {
    Write-Title "HARDWARE INFORMATION"
    
    Write-Host ""
    $cpu = Get-CimInstance Win32_Processor
    $ram = Get-CimInstance Win32_ComputerSystem
    $gpu = Get-CimInstance Win32_VideoController
    $disk = Get-CimInstance Win32_DiskDrive | Where-Object { $_.MediaType -like "*fixed*" }
    
    Write-Host "   +-- CPU -----------------------------------------------------------------------+" -ForegroundColor $cCyan
    Write-Host "   |  $($cpu.Name)" -ForegroundColor $cWhite
    Write-Host "   |  Cores: $($cpu.NumberOfCores) | Threads: $($cpu.NumberOfLogicalProcessors)" -ForegroundColor $cGray
    Write-Host ""
    
    Write-Host "   +-- MEMORY --------------------------------------------------------------------+" -ForegroundColor $cGreen
    $ramGB = [math]::Round($ram.TotalPhysicalMemory / 1GB, 2)
    Write-Host "   |  Total RAM: $ramGB GB" -ForegroundColor $cWhite
    Write-Host ""
    
    Write-Host "   +-- GPU -----------------------------------------------------------------------+" -ForegroundColor $cMag
    foreach ($g in $gpu) {
        $vramGB = [math]::Round($g.AdapterRAM / 1GB, 2)
        Write-Host "   |  $($g.Name)" -ForegroundColor $cWhite
        Write-Host "   |  VRAM: $vramGB GB" -ForegroundColor $cGray
    }
    Write-Host ""
    
    Write-Host "   +-- STORAGE -------------------------------------------------------------------+" -ForegroundColor $cYellow
    foreach ($d in $disk) {
        $sizeGB = [math]::Round($d.Size / 1GB, 2)
        Write-Host "   |  $($d.Model) - $sizeGB GB" -ForegroundColor $cWhite
    }
    Write-Host ""
    
    Read-Host "   Press Enter to return..."
}

# --- MENU WINGET ---
function Show-WingetMenu {
    while ($true) {
        Write-Title "WINGET APPLICATION HUB"
        
        Write-Host "   [*] INSTALLATION PACKAGES" -ForegroundColor $cYellow
        Write-Host ""
        Write-Host "      [1] Essential Pack + Gaming Libs" -ForegroundColor $cWhite
        Write-Host "          Chrome, Firefox, VLC, DirectX, VC++ All..." -ForegroundColor $cGray
        Write-Host ""
        Write-Host "      [2] LTSC Recovery (Advanced)" -ForegroundColor $cWhite
        Write-Host "          Store Recovery, Service Check and Media Player" -ForegroundColor $cGray
        Write-Host ""
        Write-Host "      [3] Developer Tools" -ForegroundColor $cWhite
        Write-Host "          Select Languages, IDEs, DBs manually" -ForegroundColor $cGray
        Write-Host ""
        Write-SeparatorLine
        Write-Host "      [0] Back to Main Menu" -ForegroundColor $cRed
        Write-Host ""
        
        $wop = Read-Host "   root@barzola_apps:~$"
        
        switch ($wop) {
            "0" { return }
            "1" { Install-Essentials }
            "2" { Install-LTSC }
            "3" { Install-Devs }
            default { Write-Host "   [!] Invalid option." -ForegroundColor $cRed; Start-Sleep 1 }
        }
    }
}

function Install-Winget {
    param([string]$Id, [string]$Name)
    Write-Status "Installing: $Name" "RUN"
    try {
        winget install -e --id $Id --accept-package-agreements --accept-source-agreements --silent
        Write-Status "$Name installed successfully" "OK"
    }
    catch {
        Write-Status "Failed to install $Name" "ERROR"
    }
}

function Install-Essentials {
    Write-Title "ESSENTIAL PACK + GAMING LIBRARIES"
    
    Write-Host ""
    Write-Host "   [*] APPS and MULTIMEDIA" -ForegroundColor $cMag
    Install-Winget "Google.Chrome" "Chrome"
    Install-Winget "Mozilla.Firefox" "Firefox"
    Install-Winget "VideoLAN.VLC" "VLC Media Player"
    Install-Winget "AIMP.AIMP" "AIMP"
    Install-Winget "qBittorrent.qBittorrent" "qBittorrent"
    
    Write-Host ""
    Write-Host "   [*] GAMING RUNTIMES" -ForegroundColor $cMag
    Install-Winget "Microsoft.DirectX" "DirectX End-User Runtime"
    Install-Winget "Microsoft.XNARedist" "Microsoft XNA Framework"
    Install-Winget "Microsoft.DotNet.DesktopRuntime.8" ".NET Desktop Runtime 8"
    
    Write-Host ""
    Write-Host "   [*] VISUAL C++ REDISTRIBUTABLES" -ForegroundColor $cMag
    Install-Winget "Microsoft.VCRedist.2005.x64" "VC++ 2005"
    Install-Winget "Microsoft.VCRedist.2008.x64" "VC++ 2008"
    Install-Winget "Microsoft.VCRedist.2010.x64" "VC++ 2010"
    Install-Winget "Microsoft.VCRedist.2012.x64" "VC++ 2012"
    Install-Winget "Microsoft.VCRedist.2013.x64" "VC++ 2013"
    Install-Winget "Microsoft.VCRedist.2015+.x64" "VC++ 2015-2022 (AIO)"
    
    Write-Host ""
    Write-Status "All Essentials and Libraries Deployed!" "OK"
    Read-Host "   Press Enter to return..."
}

function Install-LTSC {
    Write-Title "LTSC RECOVERY PROTOCOL"
    
    Write-Host ""
    Write-Status "Checking Core Services..." "RUN"
    $reqServices = "wuauserv", "AppXSvc", "ClipSVC"
    
    foreach ($srv in $reqServices) {
        $sStatus = Get-Service -Name $srv -ErrorAction SilentlyContinue
        if ($null -eq $sStatus) {
            Write-Status "Service not found: $srv" "WARN"
        }
        elseif ($sStatus.Status -ne 'Running') {
            Write-Status "Starting Service: $srv" "RUN"
            Set-Service -Name $srv -StartupType Manual -ErrorAction SilentlyContinue
            Start-Service -Name $srv -ErrorAction SilentlyContinue
        }
        else {
            Write-Status "Service Running: $srv" "OK"
        }
    }
    
    Write-Host ""
    Write-Status "Executing Store Recovery..." "RUN"
    Write-Host "   This may take 2-3 minutes..." -ForegroundColor $cGray
    
    wsreset -i
    
    # Progress simulation
    for ($i = 0; $i -lt 30; $i++) {
        Write-Host "." -NoNewline -ForegroundColor $cGreen
        Start-Sleep -Seconds 2
    }
    Write-Host ""
    
    if (Test-Path "$env:ProgramFiles\WindowsApps\Microsoft.WindowsStore*") {
        Write-Status "Microsoft Store detected!" "OK"
    }
    else {
        Write-Status "Store not found. Retrying..." "WARN"
        wsreset -i
        Start-Sleep -Seconds 30
        
        if (Test-Path "$env:ProgramFiles\WindowsApps\Microsoft.WindowsStore*") {
            Write-Status "Microsoft Store detected on retry!" "OK"
        }
        else {
            Write-Status "Store installation failed. Check Internet/Windows Update." "ERROR"
        }
    }
    
    Write-Host ""
    Write-Status "Enabling Windows Media Player..." "RUN"
    dism /online /enable-feature /featurename:WindowsMediaPlayer /all
    
    Write-Host ""
    Write-Status "Recovery Protocol Complete!" "OK"
    Read-Host "   Press Enter to return..."
}

function Install-Devs {
    Write-Title "DEVELOPER TOOLKIT"
    
    Write-Host ""
    Write-Host "   Select IDs separated by SPACE (Example: 1 6 11)" -ForegroundColor $cYellow
    Write-Host ""
    Write-Host "   +-- LANGUAGES -------------+-- IDE / EDITORS ----------------------------+" -ForegroundColor $cCyan
    Write-Host "   |  1. Python 3             |  6. VS Code                                 |" -ForegroundColor $cWhite
    Write-Host "   |  2. Node.js (LTS)        |  7. Windsurf IDE                            |" -ForegroundColor $cWhite
    Write-Host "   |  3. Go Lang              |  8. Google Antigravity                      |" -ForegroundColor $cWhite
    Write-Host "   |  4. PHP                  |                                             |" -ForegroundColor $cWhite
    Write-Host "   |  5. Java JDK 21          |                                             |" -ForegroundColor $cWhite
    Write-Host "   +-- TOOLS / DB ------------+-- WEB / FRAMEWORKS -------------------------+" -ForegroundColor $cCyan
    Write-Host "   |  9. Docker Desktop       |  13. Comet Browser                          |" -ForegroundColor $cWhite
    Write-Host "   |  10. Postman             |  14. Angular CLI (npm)                      |" -ForegroundColor $cWhite
    Write-Host "   |  11. Git                 |                                             |" -ForegroundColor $cWhite
    Write-Host "   |  12. MySQL Workbench     |                                             |" -ForegroundColor $cWhite
    Write-Host "   +-----------------------------+---------------------------------------------+" -ForegroundColor $cCyan
    Write-Host ""
    
    $sel = Read-Host "   root@barzola_dev:~$"
    
    if ([string]::IsNullOrEmpty($sel)) { return }
    
    $items = $sel -split " "
    
    foreach ($i in $items) {
        switch ($i) {
            "1" { Install-Winget "Python.Python.3.12" "Python 3.12" }
            "2" { Install-Winget "OpenJS.NodeJS.LTS" "Node.js LTS" }
            "3" { Install-Winget "GoLang.Go" "Go Lang" }
            "4" { Install-Winget "PHP.PHP" "PHP" }
            "5" { Install-Winget "Oracle.JDK.21" "Java JDK 21" }
            "6" { Install-Winget "Microsoft.VisualStudioCode" "VS Code" }
            "7" { Install-Winget "Codeium.Windsurf" "Windsurf IDE" }
            "8" { Install-Winget "Google.Antigravity" "Google Antigravity" }
            "9" { Install-Winget "Docker.DockerDesktop" "Docker Desktop" }
            "10" { Install-Winget "Postman.Postman" "Postman" }
            "11" { Install-Winget "Git.Git" "Git" }
            "12" { Install-Winget "Oracle.MySQLWorkbench" "MySQL Workbench" }
            "13" { Install-Winget "Perplexity.Comet" "Comet Browser" }
            "14" { 
                Write-Status "Installing Angular CLI (npm)..." "RUN"
                npm install -g @angular/cli
                Write-Status "Angular CLI installed" "OK"
            }
        }
    }
    
    Write-Host ""
    Write-Status "Selected tools installed!" "OK"
    Read-Host "   Press Enter to return..."
}

# --- PUNTO DE ENTRADA ---
Show-Menu
