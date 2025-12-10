# 🔥 JOHN BARZOLA XTREME PANEL

<p align="center">
  <img src="https://img.shields.io/badge/version-12.0-blue?style=for-the-badge" alt="Version"/>
  <img src="https://img.shields.io/badge/platform-Windows%2010%2F11-blue?style=for-the-badge" alt="Platform"/>
  <img src="https://img.shields.io/badge/PowerShell-5.1+-purple?style=for-the-badge" alt="PowerShell"/>
  <img src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" alt="License"/>
</p>

<p align="center">
  <b>Un panel de administración de sistema todo-en-uno con estética cyberpunk</b><br>
  <i>System maintenance, software deployment, and optimization tools in one place</i>
</p>

---

## ⚡ Quick Start (Remote Execution)

### Method 1: One-liner (Recommended)

Open **PowerShell as Administrator** and run:

```powershell
irm https://raw.githubusercontent.com/johnblack593/Script/main/BarzolaCyberPanel.ps1 | iex
```

### Method 2: Download and Run

```powershell
# Download
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/johnblack593/Script/main/BarzolaCyberPanel.ps1" -OutFile "$env:TEMP\BarzolaCyberPanel.ps1"

# Execute
& "$env:TEMP\BarzolaCyberPanel.ps1"
```

### Method 3: Clone Repository

```powershell
git clone https://github.com/johnblack593/Script.git
cd Script
.\BarzolaCyberPanel.ps1
```

---

## 🎯 Features

### 🔌 External Tools
| Tool | Description |
|------|-------------|
| **Chris Titus WinUtil** | Complete Windows optimization, debloat, and tweaks |
| **IT-Tea Tool** | Lightweight system cleaner |
| **Microsoft Activation (MAS)** | HWID-based Windows/Office activation |

### 🔧 System Maintenance
| Function | Description |
|----------|-------------|
| **Deep Repair Protocol** | DISM + SFC + Driver cleanup combo |
| **Network Doctor** | Reset DNS, Winsock, and TCP/IP stack |

### 📦 Software Hub (Winget)
| Package | Includes |
|---------|----------|
| **Essential Pack** | Chrome, Firefox, VLC, AIMP, qBittorrent |
| **Gaming Libraries** | DirectX, XNA, .NET 8, VC++ 2005-2022 |
| **Developer Tools** | Python, Node.js, Go, VS Code, Docker, Git, etc. |
| **LTSC Recovery** | Microsoft Store recovery for LTSC editions |

### 🛡️ Extras
| Feature | Description |
|---------|-------------|
| **Hardware Info** | Display CPU, RAM, GPU, and storage details |
| **Connection Check** | Auto-detect online/offline status |

---

## 📸 Screenshots

```
    ____  _   _  ____   _____  ____           ____   ___   ____   _____  
   / ___|| | | ||  _ \ | ____||  _ \         / ___| / _ \ |  _ \ | ____| 
  | |    | |_| || |_) ||  _|  | |_) | _____ | |    | | | || |_) ||  _|   
  | |___ |  _  ||  __/ | |___ |  _ < |_____|| |___ | |_| ||  _ < | |___  
   \____||_| |_||_|    |_____||_| \_\        \____| \___/ |_| \_\|_____| 

                    +===========================================+
                    |   JOHN BARZOLA XTREME PANEL v12.0         |
                    |        CYBER-CORE SYSTEM TOOLS            |
                    +===========================================+
```

---

## 📋 Requirements

- **OS**: Windows 10/11 (any edition, including LTSC)
- **PowerShell**: 5.1 or higher
- **Privileges**: Administrator required
- **Internet**: Required for external tools and Winget installations

---

## 🔒 Security

- **No telemetry** - This script does not collect any user data
- **Open source** - Review the code before running
- **Admin required** - Script will prompt for elevation if needed
- **External tools** - Uses trusted sources (Chris Titus, MAS official repos)

⚠️ **Warning**: Always review scripts before running them with administrative privileges.

---

## 🛠️ Configuration

### Customizing Package Lists

Edit the `Install-Essentials`, `Install-LTSC`, or `Install-Devs` functions to add/remove packages:

```powershell
# Example: Add a new package
Install-Winget "Discord.Discord" "Discord"
```

### Finding Winget Package IDs

```powershell
winget search "package name"
```

---

## 📝 Changelog

### v12.0 (Current)
- ✨ Converted to pure PowerShell for GitHub remote execution
- ✨ Added ASCII art banner
- ✨ Improved UI with box-drawing characters
- ✨ Added connection status indicator
- ✨ Added Hardware Info module
- ✨ Better error handling with try/catch
- ✨ Confirmation prompts for critical operations
- 🔧 Silent Winget installations
- 🔧 Removed password system for public release

### v10.0
- Initial hybrid BAT/PowerShell version

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👤 Author

**John Barzola**

- GitHub: [@johnblack593](https://github.com/johnblack593)

---

## ⭐ Star History

If you find this project useful, please consider giving it a star! ⭐

---

<p align="center">
  Made with 💜 and PowerShell
</p>
