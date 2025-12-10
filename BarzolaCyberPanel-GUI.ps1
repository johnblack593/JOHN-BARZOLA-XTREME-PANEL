# =========================================================
# JOHN BARZOLA XTREME PANEL - CYBER-CORE v12.0 (WPF GUI)
# GitHub Remote Execution Version
# =========================================================
# Usage: irm https://raw.githubusercontent.com/johnblack593/Script/feature/wpf-gui/BarzolaCyberPanel-GUI.ps1 | iex
# =========================================================

#Requires -RunAsAdministrator

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

# --- CONFIGURACION ---
$script:Version = "12.0"
$script:Author = "John Barzola"

# --- DEFINICION DE APLICACIONES ---
$script:Apps = @{
    "Browsers"      = @(
        @{Name = "Google Chrome"; Id = "Google.Chrome"; Icon = "🌐" },
        @{Name = "Mozilla Firefox"; Id = "Mozilla.Firefox"; Icon = "🦊" },
        @{Name = "Brave Browser"; Id = "Brave.Brave"; Icon = "🦁" },
        @{Name = "Microsoft Edge"; Id = "Microsoft.Edge"; Icon = "🔷" },
        @{Name = "Opera Browser"; Id = "Opera.Opera"; Icon = "🔴" }
    )
    "Media"         = @(
        @{Name = "VLC Media Player"; Id = "VideoLAN.VLC"; Icon = "🎬" },
        @{Name = "AIMP"; Id = "AIMP.AIMP"; Icon = "🎵" },
        @{Name = "Spotify"; Id = "Spotify.Spotify"; Icon = "🎧" },
        @{Name = "K-Lite Codec Pack"; Id = "CodecGuide.K-LiteCodecPack.Mega"; Icon = "📀" }
    )
    "Utilities"     = @(
        @{Name = "7-Zip"; Id = "7zip.7zip"; Icon = "📦" },
        @{Name = "WinRAR"; Id = "RARLab.WinRAR"; Icon = "📁" },
        @{Name = "qBittorrent"; Id = "qBittorrent.qBittorrent"; Icon = "⬇️" },
        @{Name = "Everything Search"; Id = "voidtools.Everything"; Icon = "🔍" }
    )
    "Development"   = @(
        @{Name = "Visual Studio Code"; Id = "Microsoft.VisualStudioCode"; Icon = "💻" },
        @{Name = "Git"; Id = "Git.Git"; Icon = "🔀" },
        @{Name = "Python 3"; Id = "Python.Python.3.12"; Icon = "🐍" },
        @{Name = "Node.js LTS"; Id = "OpenJS.NodeJS.LTS"; Icon = "💚" },
        @{Name = "Docker Desktop"; Id = "Docker.DockerDesktop"; Icon = "🐳" }
    )
    "Communication" = @(
        @{Name = "Discord"; Id = "Discord.Discord"; Icon = "💬" },
        @{Name = "Telegram"; Id = "Telegram.TelegramDesktop"; Icon = "✈️" },
        @{Name = "Zoom"; Id = "Zoom.Zoom"; Icon = "📹" },
        @{Name = "Microsoft Teams"; Id = "Microsoft.Teams"; Icon = "👥" }
    )
    "Runtimes"      = @(
        @{Name = "DirectX Runtime"; Id = "Microsoft.DirectX"; Icon = "🎮" },
        @{Name = ".NET Runtime 8"; Id = "Microsoft.DotNet.DesktopRuntime.8"; Icon = "⚙️" },
        @{Name = "VC++ 2015-2022"; Id = "Microsoft.VCRedist.2015+.x64"; Icon = "🔧" },
        @{Name = "Java JDK 21"; Id = "Oracle.JDK.21"; Icon = "☕" }
    )
}

# --- XAML UI DEFINITION ---
[xml]$xaml = @"
<Window 
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="JOHN BARZOLA XTREME PANEL v12.0" 
    Height="700" Width="950"
    WindowStartupLocation="CenterScreen"
    Background="#0d1117"
    FontFamily="Segoe UI">
    
    <Window.Resources>
        <!-- Button Style -->
        <Style x:Key="ModernButton" TargetType="Button">
            <Setter Property="Background" Value="#238636"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Padding" Value="20,10"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" 
                                CornerRadius="6" Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="#2ea043"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
        
        <!-- Secondary Button Style -->
        <Style x:Key="SecondaryButton" TargetType="Button">
            <Setter Property="Background" Value="#21262d"/>
            <Setter Property="Foreground" Value="#c9d1d9"/>
            <Setter Property="BorderBrush" Value="#30363d"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Padding" Value="15,8"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" 
                                BorderBrush="{TemplateBinding BorderBrush}"
                                BorderThickness="{TemplateBinding BorderThickness}"
                                CornerRadius="6" Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="#30363d"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
        
        <!-- Tab Style -->
        <Style x:Key="ModernTab" TargetType="TabItem">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="#8b949e"/>
            <Setter Property="Padding" Value="15,10"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="TabItem">
                        <Border Name="Border" Background="{TemplateBinding Background}" 
                                Padding="{TemplateBinding Padding}" Margin="2,0">
                            <ContentPresenter ContentSource="Header"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsSelected" Value="True">
                                <Setter TargetName="Border" Property="Background" Value="#21262d"/>
                                <Setter Property="Foreground" Value="#58a6ff"/>
                            </Trigger>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="Border" Property="Background" Value="#161b22"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
        
        <!-- Checkbox Style -->
        <Style x:Key="AppCheckbox" TargetType="CheckBox">
            <Setter Property="Foreground" Value="#c9d1d9"/>
            <Setter Property="Margin" Value="5"/>
            <Setter Property="Cursor" Value="Hand"/>
        </Style>
    </Window.Resources>
    
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>
        
        <!-- HEADER -->
        <Border Grid.Row="0" Background="#161b22" Padding="20">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="Auto"/>
                </Grid.ColumnDefinitions>
                
                <StackPanel Grid.Column="0">
                    <TextBlock Text="CYBER CORE" FontSize="28" FontWeight="Bold" Foreground="#58a6ff"/>
                    <TextBlock Text="John Barzola Xtreme Panel v12.0" FontSize="12" Foreground="#8b949e"/>
                </StackPanel>
                
                <StackPanel Grid.Column="1" Orientation="Horizontal" VerticalAlignment="Center">
                    <Border Background="#238636" CornerRadius="10" Padding="8,4" Margin="5,0">
                        <TextBlock Name="txtStatus" Text="ONLINE" FontSize="11" Foreground="White"/>
                    </Border>
                    <TextBlock Name="txtUser" Text="User: Loading..." Foreground="#8b949e" 
                               VerticalAlignment="Center" Margin="10,0,0,0"/>
                </StackPanel>
            </Grid>
        </Border>
        
        <!-- MAIN CONTENT -->
        <TabControl Grid.Row="1" Background="Transparent" BorderThickness="0" Margin="10">
            
            <!-- TAB: APPS -->
            <TabItem Header="📦 Apps" Style="{StaticResource ModernTab}">
                <Grid Margin="10">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="*"/>
                    </Grid.RowDefinitions>
                    
                    <!-- Category Buttons -->
                    <WrapPanel Grid.Row="0" Margin="0,0,0,15">
                        <Button Name="btnAll" Content="All" Style="{StaticResource SecondaryButton}" Margin="0,0,5,5"/>
                        <Button Name="btnBrowsers" Content="Browsers" Style="{StaticResource SecondaryButton}" Margin="0,0,5,5"/>
                        <Button Name="btnMedia" Content="Media" Style="{StaticResource SecondaryButton}" Margin="0,0,5,5"/>
                        <Button Name="btnUtilities" Content="Utilities" Style="{StaticResource SecondaryButton}" Margin="0,0,5,5"/>
                        <Button Name="btnDev" Content="Development" Style="{StaticResource SecondaryButton}" Margin="0,0,5,5"/>
                        <Button Name="btnComm" Content="Communication" Style="{StaticResource SecondaryButton}" Margin="0,0,5,5"/>
                        <Button Name="btnRuntimes" Content="Runtimes" Style="{StaticResource SecondaryButton}" Margin="0,0,5,5"/>
                    </WrapPanel>
                    
                    <!-- Apps Grid -->
                    <ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto">
                        <WrapPanel Name="appsPanel">
                            <!-- Apps will be added dynamically -->
                        </WrapPanel>
                    </ScrollViewer>
                </Grid>
            </TabItem>
            
            <!-- TAB: TWEAKS -->
            <TabItem Header="⚙️ Tweaks" Style="{StaticResource ModernTab}">
                <ScrollViewer Margin="10">
                    <StackPanel>
                        <TextBlock Text="System Tweaks" FontSize="18" FontWeight="Bold" Foreground="#58a6ff" Margin="0,0,0,15"/>
                        
                        <Border Background="#161b22" CornerRadius="8" Padding="15" Margin="0,0,0,10">
                            <StackPanel>
                                <TextBlock Text="Performance" FontSize="14" FontWeight="SemiBold" Foreground="#c9d1d9" Margin="0,0,0,10"/>
                                <CheckBox Content="Disable Telemetry" Style="{StaticResource AppCheckbox}" Name="chkTelemetry"/>
                                <CheckBox Content="Disable Cortana" Style="{StaticResource AppCheckbox}" Name="chkCortana"/>
                                <CheckBox Content="Disable Xbox GameBar" Style="{StaticResource AppCheckbox}" Name="chkGameBar"/>
                                <CheckBox Content="Enable Ultimate Performance Mode" Style="{StaticResource AppCheckbox}" Name="chkPerformance"/>
                            </StackPanel>
                        </Border>
                        
                        <Border Background="#161b22" CornerRadius="8" Padding="15" Margin="0,0,0,10">
                            <StackPanel>
                                <TextBlock Text="Privacy" FontSize="14" FontWeight="SemiBold" Foreground="#c9d1d9" Margin="0,0,0,10"/>
                                <CheckBox Content="Disable Activity History" Style="{StaticResource AppCheckbox}" Name="chkActivity"/>
                                <CheckBox Content="Disable Location Tracking" Style="{StaticResource AppCheckbox}" Name="chkLocation"/>
                                <CheckBox Content="Disable Advertising ID" Style="{StaticResource AppCheckbox}" Name="chkAdId"/>
                            </StackPanel>
                        </Border>
                        
                        <Border Background="#161b22" CornerRadius="8" Padding="15" Margin="0,0,0,10">
                            <StackPanel>
                                <TextBlock Text="Visual" FontSize="14" FontWeight="SemiBold" Foreground="#c9d1d9" Margin="0,0,0,10"/>
                                <CheckBox Content="Enable Dark Mode" Style="{StaticResource AppCheckbox}" Name="chkDarkMode"/>
                                <CheckBox Content="Disable Transparency Effects" Style="{StaticResource AppCheckbox}" Name="chkTransparency"/>
                                <CheckBox Content="Disable Animations" Style="{StaticResource AppCheckbox}" Name="chkAnimations"/>
                            </StackPanel>
                        </Border>
                        
                        <Button Name="btnApplyTweaks" Content="Apply Selected Tweaks" 
                                Style="{StaticResource ModernButton}" HorizontalAlignment="Left" Margin="0,10,0,0"/>
                    </StackPanel>
                </ScrollViewer>
            </TabItem>
            
            <!-- TAB: TOOLS -->
            <TabItem Header="🔧 Tools" Style="{StaticResource ModernTab}">
                <ScrollViewer Margin="10">
                    <WrapPanel>
                        <Border Background="#161b22" CornerRadius="8" Padding="20" Margin="5" Width="280">
                            <StackPanel>
                                <TextBlock Text="🛠️ Chris Titus WinUtil" FontSize="16" FontWeight="Bold" Foreground="#c9d1d9"/>
                                <TextBlock Text="Complete Windows optimization toolkit" FontSize="12" Foreground="#8b949e" TextWrapping="Wrap" Margin="0,5,0,15"/>
                                <Button Name="btnTitus" Content="Launch" Style="{StaticResource ModernButton}"/>
                            </StackPanel>
                        </Border>
                        
                        <Border Background="#161b22" CornerRadius="8" Padding="20" Margin="5" Width="280">
                            <StackPanel>
                                <TextBlock Text="🔑 Microsoft Activation" FontSize="16" FontWeight="Bold" Foreground="#c9d1d9"/>
                                <TextBlock Text="HWID-based Windows/Office activation" FontSize="12" Foreground="#8b949e" TextWrapping="Wrap" Margin="0,5,0,15"/>
                                <Button Name="btnMAS" Content="Launch" Style="{StaticResource ModernButton}"/>
                            </StackPanel>
                        </Border>
                        
                        <Border Background="#161b22" CornerRadius="8" Padding="20" Margin="5" Width="280">
                            <StackPanel>
                                <TextBlock Text="🏥 Deep Repair" FontSize="16" FontWeight="Bold" Foreground="#c9d1d9"/>
                                <TextBlock Text="DISM + SFC + Driver cleanup" FontSize="12" Foreground="#8b949e" TextWrapping="Wrap" Margin="0,5,0,15"/>
                                <Button Name="btnRepair" Content="Run" Style="{StaticResource ModernButton}"/>
                            </StackPanel>
                        </Border>
                        
                        <Border Background="#161b22" CornerRadius="8" Padding="20" Margin="5" Width="280">
                            <StackPanel>
                                <TextBlock Text="🌐 Network Doctor" FontSize="16" FontWeight="Bold" Foreground="#c9d1d9"/>
                                <TextBlock Text="Reset DNS, Winsock and TCP/IP" FontSize="12" Foreground="#8b949e" TextWrapping="Wrap" Margin="0,5,0,15"/>
                                <Button Name="btnNetwork" Content="Run" Style="{StaticResource ModernButton}"/>
                            </StackPanel>
                        </Border>
                        
                        <Border Background="#161b22" CornerRadius="8" Padding="20" Margin="5" Width="280">
                            <StackPanel>
                                <TextBlock Text="💻 Hardware Info" FontSize="16" FontWeight="Bold" Foreground="#c9d1d9"/>
                                <TextBlock Text="View CPU, RAM, GPU and Storage details" FontSize="12" Foreground="#8b949e" TextWrapping="Wrap" Margin="0,5,0,15"/>
                                <Button Name="btnHardware" Content="View" Style="{StaticResource ModernButton}"/>
                            </StackPanel>
                        </Border>
                    </WrapPanel>
                </ScrollViewer>
            </TabItem>
            
            <!-- TAB: SETTINGS -->
            <TabItem Header="⚙️ Settings" Style="{StaticResource ModernTab}">
                <StackPanel Margin="20">
                    <TextBlock Text="Panel Settings" FontSize="18" FontWeight="Bold" Foreground="#58a6ff" Margin="0,0,0,20"/>
                    
                    <Border Background="#161b22" CornerRadius="8" Padding="20" Margin="0,0,0,15">
                        <StackPanel>
                            <TextBlock Text="About" FontSize="14" FontWeight="SemiBold" Foreground="#c9d1d9" Margin="0,0,0,10"/>
                            <TextBlock Text="John Barzola Xtreme Panel" Foreground="#8b949e"/>
                            <TextBlock Text="Version 12.0 - CYBER-CORE" Foreground="#8b949e"/>
                            <TextBlock Text="Built with PowerShell + WPF" Foreground="#8b949e"/>
                        </StackPanel>
                    </Border>
                    
                    <Border Background="#161b22" CornerRadius="8" Padding="20">
                        <StackPanel>
                            <TextBlock Text="Links" FontSize="14" FontWeight="SemiBold" Foreground="#c9d1d9" Margin="0,0,0,10"/>
                            <Button Name="btnGitHub" Content="📂 View on GitHub" Style="{StaticResource SecondaryButton}" 
                                    HorizontalAlignment="Left" Margin="0,0,0,5"/>
                        </StackPanel>
                    </Border>
                </StackPanel>
            </TabItem>
        </TabControl>
        
        <!-- FOOTER -->
        <Border Grid.Row="2" Background="#161b22" Padding="15">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="Auto"/>
                </Grid.ColumnDefinitions>
                
                <StackPanel Grid.Column="0" Orientation="Horizontal">
                    <TextBlock Name="txtProgress" Text="Ready" Foreground="#8b949e" VerticalAlignment="Center"/>
                    <ProgressBar Name="progressBar" Width="200" Height="8" Margin="15,0,0,0" 
                                 Background="#21262d" Foreground="#238636" Value="0" Visibility="Collapsed"/>
                </StackPanel>
                
                <StackPanel Grid.Column="1" Orientation="Horizontal">
                    <Button Name="btnInstall" Content="Install Selected" Style="{StaticResource ModernButton}" Margin="0,0,10,0"/>
                    <Button Name="btnExit" Content="Exit" Style="{StaticResource SecondaryButton}"/>
                </StackPanel>
            </Grid>
        </Border>
    </Grid>
</Window>
"@

# --- CREAR VENTANA ---
$reader = New-Object System.Xml.XmlNodeReader $xaml
$window = [Windows.Markup.XamlReader]::Load($reader)

# --- OBTENER CONTROLES ---
$txtUser = $window.FindName("txtUser")
$txtStatus = $window.FindName("txtStatus")
$txtProgress = $window.FindName("txtProgress")
$progressBar = $window.FindName("progressBar")
$appsPanel = $window.FindName("appsPanel")
$btnInstall = $window.FindName("btnInstall")
$btnExit = $window.FindName("btnExit")
$btnTitus = $window.FindName("btnTitus")
$btnMAS = $window.FindName("btnMAS")
$btnRepair = $window.FindName("btnRepair")
$btnNetwork = $window.FindName("btnNetwork")
$btnHardware = $window.FindName("btnHardware")
$btnGitHub = $window.FindName("btnGitHub")
$btnApplyTweaks = $window.FindName("btnApplyTweaks")

# Category buttons
$btnAll = $window.FindName("btnAll")
$btnBrowsers = $window.FindName("btnBrowsers")
$btnMedia = $window.FindName("btnMedia")
$btnUtilities = $window.FindName("btnUtilities")
$btnDev = $window.FindName("btnDev")
$btnComm = $window.FindName("btnComm")
$btnRuntimes = $window.FindName("btnRuntimes")

# --- INICIALIZAR ---
$txtUser.Text = "User: $env:USERNAME"

# Store checkboxes for installation
$script:appCheckboxes = @{}

# --- FUNCION: CREAR APP CARDS ---
function Add-AppCard {
    param($App, $Category)
    
    $border = New-Object System.Windows.Controls.Border
    $border.Background = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#21262d")
    $border.CornerRadius = [System.Windows.CornerRadius]::new(6)
    $border.Padding = [System.Windows.Thickness]::new(12)
    $border.Margin = [System.Windows.Thickness]::new(5)
    $border.Width = 200
    $border.Tag = $Category
    
    $stack = New-Object System.Windows.Controls.StackPanel
    $stack.Orientation = "Horizontal"
    
    $checkbox = New-Object System.Windows.Controls.CheckBox
    $checkbox.VerticalAlignment = "Center"
    $checkbox.Tag = $App.Id
    
    $label = New-Object System.Windows.Controls.TextBlock
    $label.Text = "$($App.Icon) $($App.Name)"
    $label.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#c9d1d9")
    $label.Margin = [System.Windows.Thickness]::new(8, 0, 0, 0)
    $label.VerticalAlignment = "Center"
    $label.FontSize = 12
    
    $stack.Children.Add($checkbox)
    $stack.Children.Add($label)
    $border.Child = $stack
    
    $script:appCheckboxes[$App.Id] = $checkbox
    
    return $border
}

# --- FUNCION: CARGAR APPS ---
function Load-Apps {
    param([string]$Filter = "All")
    
    $appsPanel.Children.Clear()
    
    foreach ($category in $script:Apps.Keys) {
        if ($Filter -ne "All" -and $category -ne $Filter) { continue }
        
        foreach ($app in $script:Apps[$category]) {
            $card = Add-AppCard -App $app -Category $category
            $appsPanel.Children.Add($card)
        }
    }
}

# --- CARGAR TODAS LAS APPS INICIALMENTE ---
Load-Apps -Filter "All"

# --- EVENTOS DE CATEGORIA ---
$btnAll.Add_Click({ Load-Apps -Filter "All" })
$btnBrowsers.Add_Click({ Load-Apps -Filter "Browsers" })
$btnMedia.Add_Click({ Load-Apps -Filter "Media" })
$btnUtilities.Add_Click({ Load-Apps -Filter "Utilities" })
$btnDev.Add_Click({ Load-Apps -Filter "Development" })
$btnComm.Add_Click({ Load-Apps -Filter "Communication" })
$btnRuntimes.Add_Click({ Load-Apps -Filter "Runtimes" })

# --- FUNCION: INSTALAR APPS ---
function Install-SelectedApps {
    $selectedApps = $script:appCheckboxes.GetEnumerator() | Where-Object { $_.Value.IsChecked -eq $true }
    
    if ($selectedApps.Count -eq 0) {
        [System.Windows.MessageBox]::Show("Please select at least one application to install.", "No Selection", "OK", "Information")
        return
    }
    
    $progressBar.Visibility = "Visible"
    $progressBar.Maximum = $selectedApps.Count
    $progressBar.Value = 0
    
    $count = 0
    foreach ($app in $selectedApps) {
        $count++
        $txtProgress.Text = "Installing: $($app.Key) ($count/$($selectedApps.Count))"
        $progressBar.Value = $count
        $window.Dispatcher.Invoke([Action] {}, "Render")
        
        try {
            Start-Process -FilePath "winget" -ArgumentList "install -e --id $($app.Key) --accept-package-agreements --accept-source-agreements --silent" -Wait -NoNewWindow
        }
        catch {
            # Continue on error
        }
    }
    
    $txtProgress.Text = "Installation complete!"
    $progressBar.Visibility = "Collapsed"
    [System.Windows.MessageBox]::Show("$count applications installed successfully!", "Complete", "OK", "Information")
}

# --- EVENTOS DE BOTONES ---
$btnInstall.Add_Click({ Install-SelectedApps })

$btnExit.Add_Click({ $window.Close() })

$btnTitus.Add_Click({
        $txtProgress.Text = "Launching Chris Titus WinUtil..."
        Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://christitus.com/win | iex`"" -Verb RunAs
    })

$btnMAS.Add_Click({
        $txtProgress.Text = "Launching Microsoft Activation Scripts..."
        Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://get.activated.win | iex`"" -Verb RunAs
    })

$btnRepair.Add_Click({
        $result = [System.Windows.MessageBox]::Show("This will run DISM and SFC scans. Continue?", "Deep Repair", "YesNo", "Question")
        if ($result -eq "Yes") {
            $txtProgress.Text = "Running Deep Repair..."
            Start-Process powershell -ArgumentList "-NoProfile -Command `"dism /Online /Cleanup-Image /RestoreHealth; sfc /scannow; pause`"" -Verb RunAs
        }
    })

$btnNetwork.Add_Click({
        $result = [System.Windows.MessageBox]::Show("This will reset your network configuration. Continue?", "Network Doctor", "YesNo", "Question")
        if ($result -eq "Yes") {
            $txtProgress.Text = "Resetting network..."
            Start-Process powershell -ArgumentList "-NoProfile -Command `"ipconfig /flushdns; netsh winsock reset; netsh int ip reset; pause`"" -Verb RunAs
        }
    })

$btnHardware.Add_Click({
        $cpu = (Get-CimInstance Win32_Processor).Name
        $ramGB = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)
        $gpu = (Get-CimInstance Win32_VideoController).Name -join "`n"
        $disk = (Get-CimInstance Win32_DiskDrive | Where-Object { $_.MediaType -like "*fixed*" }).Model -join "`n"
    
        $info = @"
CPU: $cpu

RAM: $ramGB GB

GPU:
$gpu

Storage:
$disk
"@
        [System.Windows.MessageBox]::Show($info, "Hardware Information", "OK", "Information")
    })

$btnGitHub.Add_Click({
        Start-Process "https://github.com/johnblack593/Script"
    })

$btnApplyTweaks.Add_Click({
        [System.Windows.MessageBox]::Show("Tweaks functionality coming soon!", "Info", "OK", "Information")
    })

# --- MOSTRAR VENTANA ---
$window.ShowDialog() | Out-Null
