# =========================================================
# JOHN BARZOLA XTREME PANEL - CYBER-CORE v12.0 (WPF GUI)
# Version con interfaz grafica completa
# =========================================================

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

# --- CONFIGURACION ---
$script:Version = "12.0"
$script:Author = "John Barzola"

# --- USUARIOS AUTORIZADOS ---
$script:Users = @{
    "jbarzola" = "00199500"
    "kbarzola" = "kevinblack"
    "abarzola" = "159753456"
}

# --- DEFINICION DE APLICACIONES (igual que version consola) ---
$script:AppCategories = [ordered]@{
    "Navegadores"      = @(
        @{Name = "Google Chrome"; Id = "Google.Chrome" },
        @{Name = "Mozilla Firefox"; Id = "Mozilla.Firefox" },
        @{Name = "Brave Browser"; Id = "Brave.Brave" },
        @{Name = "Microsoft Edge"; Id = "Microsoft.Edge" },
        @{Name = "Opera Browser"; Id = "Opera.Opera" }
    )
    "Multimedia"       = @(
        @{Name = "VLC Media Player"; Id = "VideoLAN.VLC" },
        @{Name = "AIMP"; Id = "AIMP.AIMP" },
        @{Name = "Spotify"; Id = "Spotify.Spotify" },
        @{Name = "qBittorrent"; Id = "qBittorrent.qBittorrent" }
    )
    "Librerias Gaming" = @(
        @{Name = "DirectX Runtime"; Id = "Microsoft.DirectX" },
        @{Name = "Microsoft XNA Framework"; Id = "Microsoft.XNARedist" },
        @{Name = ".NET Desktop Runtime 8"; Id = "Microsoft.DotNet.DesktopRuntime.8" },
        @{Name = "Visual C++ 2005"; Id = "Microsoft.VCRedist.2005.x64" },
        @{Name = "Visual C++ 2008"; Id = "Microsoft.VCRedist.2008.x64" },
        @{Name = "Visual C++ 2010"; Id = "Microsoft.VCRedist.2010.x64" },
        @{Name = "Visual C++ 2012"; Id = "Microsoft.VCRedist.2012.x64" },
        @{Name = "Visual C++ 2013"; Id = "Microsoft.VCRedist.2013.x64" },
        @{Name = "Visual C++ 2015-2022"; Id = "Microsoft.VCRedist.2015+.x64" }
    )
    "Desarrollo"       = @(
        @{Name = "Visual Studio Code"; Id = "Microsoft.VisualStudioCode" },
        @{Name = "Windsurf IDE"; Id = "Codeium.Windsurf" },
        @{Name = "Git"; Id = "Git.Git" },
        @{Name = "Python 3.12"; Id = "Python.Python.3.12" },
        @{Name = "Node.js LTS"; Id = "OpenJS.NodeJS.LTS" },
        @{Name = "Go Lang"; Id = "GoLang.Go" },
        @{Name = "PHP"; Id = "PHP.PHP" },
        @{Name = "Java JDK 21"; Id = "Oracle.JDK.21" },
        @{Name = "Docker Desktop"; Id = "Docker.DockerDesktop" },
        @{Name = "Postman"; Id = "Postman.Postman" },
        @{Name = "MySQL Workbench"; Id = "Oracle.MySQLWorkbench" }
    )
    "Comunicacion"     = @(
        @{Name = "Discord"; Id = "Discord.Discord" },
        @{Name = "Telegram"; Id = "Telegram.TelegramDesktop" },
        @{Name = "Zoom"; Id = "Zoom.Zoom" },
        @{Name = "Microsoft Teams"; Id = "Microsoft.Teams" }
    )
    "Utilidades"       = @(
        @{Name = "7-Zip"; Id = "7zip.7zip" },
        @{Name = "WinRAR"; Id = "RARLab.WinRAR" },
        @{Name = "Everything Search"; Id = "voidtools.Everything" },
        @{Name = "Comet Browser"; Id = "Perplexity.Comet" }
    )
}

# ============================================================
# VENTANA DE LOGIN
# ============================================================
function Show-LoginWindow {
    [xml]$loginXaml = @"
<Window 
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="Chris Extreme Panel - Acceso Seguro" 
    Height="420" Width="400"
    WindowStartupLocation="CenterScreen"
    Background="#0d1117"
    ResizeMode="NoResize"
    WindowStyle="None"
    AllowsTransparency="True">
    
    <Border Background="#0d1117" CornerRadius="10" BorderBrush="#30363d" BorderThickness="1">
        <Grid>
            <Grid.RowDefinitions>
                <RowDefinition Height="40"/>
                <RowDefinition Height="*"/>
            </Grid.RowDefinitions>
            
            <Border Grid.Row="0" Background="#161b22" CornerRadius="10,10,0,0">
                <Grid>
                    <TextBlock Text="ACCESO SEGURO" FontSize="14" FontWeight="Bold" 
                               Foreground="#58a6ff" VerticalAlignment="Center" Margin="15,0"/>
                    <Button Name="btnClose" Content="X" HorizontalAlignment="Right" 
                            Background="Transparent" Foreground="#8b949e" BorderThickness="0"
                            Width="40" Height="40" FontSize="14" Cursor="Hand"/>
                </Grid>
            </Border>
            
            <StackPanel Grid.Row="1" Margin="30" VerticalAlignment="Center">
                <TextBlock Text="CHRIS EXTREME" FontSize="24" FontWeight="Bold" 
                           Foreground="#58a6ff" HorizontalAlignment="Center" Margin="0,0,0,5"/>
                <TextBlock Text="PANEL" FontSize="14" FontWeight="Bold"
                           Foreground="#8b949e" HorizontalAlignment="Center" Margin="0,0,0,30"/>
                
                <TextBlock Text="Usuario:" Foreground="#c9d1d9" Margin="0,0,0,5"/>
                <TextBox Name="txtUser" Height="35" Background="#21262d" Foreground="#c9d1d9" 
                         BorderBrush="#30363d" Padding="10,8" FontSize="14"/>
                
                <TextBlock Text="Contrasena:" Foreground="#c9d1d9" Margin="0,15,0,5"/>
                <PasswordBox Name="txtPass" Height="35" Background="#21262d" Foreground="#c9d1d9" 
                             BorderBrush="#30363d" Padding="10,8" FontSize="14"/>
                
                <TextBlock Name="txtError" Text="" Foreground="#f85149" 
                           HorizontalAlignment="Center" Margin="0,10,0,0"/>
                
                <Button Name="btnLogin" Content="INGRESAR" Height="40" Margin="0,20,0,0"
                        Background="#238636" Foreground="White" BorderThickness="0" 
                        FontSize="14" FontWeight="Bold" Cursor="Hand"/>
            </StackPanel>
        </Grid>
    </Border>
</Window>
"@

    $reader = New-Object System.Xml.XmlNodeReader $loginXaml
    $loginWindow = [Windows.Markup.XamlReader]::Load($reader)
    
    $btnClose = $loginWindow.FindName("btnClose")
    $btnLogin = $loginWindow.FindName("btnLogin")
    $txtUser = $loginWindow.FindName("txtUser")
    $txtPass = $loginWindow.FindName("txtPass")
    $txtError = $loginWindow.FindName("txtError")
    
    # Permitir arrastrar ventana
    $loginWindow.Add_MouseLeftButtonDown({ $loginWindow.DragMove() })
    
    $btnClose.Add_Click({ $loginWindow.Close(); exit })
    
    $script:AuthenticatedUser = $null
    
    $btnLogin.Add_Click({
            $user = $txtUser.Text
            $pass = $txtPass.Password
        
            if ($script:Users.ContainsKey($user) -and $script:Users[$user] -eq $pass) {
                $script:AuthenticatedUser = $user
                $loginWindow.DialogResult = $true
                $loginWindow.Close()
            }
            else {
                $txtError.Text = "Usuario o contrasena incorrectos"
            }
        })
    
    # Enter para login
    $txtPass.Add_KeyDown({
            if ($_.Key -eq "Return") { $btnLogin.RaiseEvent((New-Object System.Windows.RoutedEventArgs([System.Windows.Controls.Button]::ClickEvent))) }
        })
    
    $result = $loginWindow.ShowDialog()
    return $result
}

# ============================================================
# VENTANA PRINCIPAL
# ============================================================
function Show-MainWindow {
    [xml]$xaml = @"
<Window 
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="JOHN BARZOLA XTREME PANEL v12.0" 
    Height="750" Width="1100"
    WindowStartupLocation="CenterScreen"
    Background="#0d1117"
    FontFamily="Segoe UI">
    
    <Window.Resources>
        <Style x:Key="ModernButton" TargetType="Button">
            <Setter Property="Background" Value="#238636"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Padding" Value="15,8"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" CornerRadius="5" Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
        
        <Style x:Key="SecondaryButton" TargetType="Button">
            <Setter Property="Background" Value="#21262d"/>
            <Setter Property="Foreground" Value="#c9d1d9"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Padding" Value="12,6"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" CornerRadius="5" Padding="{TemplateBinding Padding}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
        
        <Style x:Key="ToolCard" TargetType="Border">
            <Setter Property="Background" Value="#161b22"/>
            <Setter Property="CornerRadius" Value="8"/>
            <Setter Property="Padding" Value="15"/>
            <Setter Property="Margin" Value="5"/>
        </Style>
        
        <Style x:Key="ModernTab" TargetType="TabItem">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="#8b949e"/>
            <Setter Property="Padding" Value="20,12"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="TabItem">
                        <Border Name="Border" Background="{TemplateBinding Background}" Padding="{TemplateBinding Padding}">
                            <ContentPresenter ContentSource="Header"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsSelected" Value="True">
                                <Setter TargetName="Border" Property="Background" Value="#21262d"/>
                                <Setter Property="Foreground" Value="#58a6ff"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>
    
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>
        
        <!-- HEADER -->
        <Border Grid.Row="0" Background="#161b22" Padding="20,15">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="Auto"/>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="Auto"/>
                </Grid.ColumnDefinitions>
                
                <StackPanel Grid.Column="0">
                    <TextBlock Text="CHRIS EXTREME PANEL" FontSize="22" FontWeight="Bold" Foreground="#58a6ff"/>
                    <TextBlock Name="txtWelcome" Text="Bienvenido, Usuario" FontSize="11" Foreground="#8b949e"/>
                </StackPanel>
                
                <StackPanel Grid.Column="2" Orientation="Horizontal" VerticalAlignment="Center">
                    <Border Background="#238636" CornerRadius="8" Padding="8,4" Margin="5,0">
                        <TextBlock Text="EN LINEA" FontSize="10" Foreground="White"/>
                    </Border>
                </StackPanel>
            </Grid>
        </Border>
        
        <!-- BARRA DE MONITOREO -->
        <Border Grid.Row="1" Background="#0d1117" Padding="12,8" BorderBrush="#21262d" BorderThickness="0,0,0,1">
            <WrapPanel>
                <!-- RAM -->
                <Border Background="#21262d" CornerRadius="6" Padding="12,6" Margin="0,0,10,0">
                    <StackPanel Orientation="Horizontal">
                        <TextBlock Text="[M]" Foreground="#58a6ff" FontSize="11" FontWeight="Bold" Margin="0,0,6,0"/>
                        <TextBlock Text="RAM " Foreground="#8b949e" FontSize="11"/>
                        <TextBlock Name="txtRAM" Text="--" Foreground="#58a6ff" FontSize="11" FontWeight="Bold"/>
                    </StackPanel>
                </Border>
                
                <!-- CPU (Uso + Temp agrupados) -->
                <Border Background="#21262d" CornerRadius="6" Padding="12,6" Margin="0,0,10,0">
                    <StackPanel Orientation="Horizontal">
                        <TextBlock Text="[C]" Foreground="#238636" FontSize="11" FontWeight="Bold" Margin="0,0,6,0"/>
                        <TextBlock Text="CPU " Foreground="#8b949e" FontSize="11"/>
                        <TextBlock Name="txtCPU" Text="--" Foreground="#238636" FontSize="11" FontWeight="Bold"/>
                        <TextBlock Text=" | " Foreground="#30363d" FontSize="11"/>
                        <TextBlock Name="txtCPUTemp" Text="--" Foreground="#f0883e" FontSize="11" FontWeight="Bold"/>
                    </StackPanel>
                </Border>
                
                <!-- GPU (Uso + Temp agrupados) -->
                <Border Background="#21262d" CornerRadius="6" Padding="12,6" Margin="0,0,10,0">
                    <StackPanel Orientation="Horizontal">
                        <TextBlock Text="[G]" Foreground="#a371f7" FontSize="11" FontWeight="Bold" Margin="0,0,6,0"/>
                        <TextBlock Text="GPU " Foreground="#8b949e" FontSize="11"/>
                        <TextBlock Name="txtGPU" Text="--" Foreground="#a371f7" FontSize="11" FontWeight="Bold"/>
                        <TextBlock Text=" | " Foreground="#30363d" FontSize="11"/>
                        <TextBlock Name="txtGPUTemp" Text="--" Foreground="#f0883e" FontSize="11" FontWeight="Bold"/>
                    </StackPanel>
                </Border>
                
                <!-- Disco (Espacio + Salud agrupados) -->
                <Border Background="#21262d" CornerRadius="6" Padding="12,6" Margin="0,0,10,0">
                    <StackPanel Orientation="Horizontal">
                        <TextBlock Text="[D]" Foreground="#f0883e" FontSize="11" FontWeight="Bold" Margin="0,0,6,0"/>
                        <TextBlock Text="Disco " Foreground="#8b949e" FontSize="11"/>
                        <TextBlock Name="txtDisk" Text="--" Foreground="#f0883e" FontSize="11" FontWeight="Bold"/>
                        <TextBlock Text=" | " Foreground="#30363d" FontSize="11"/>
                        <TextBlock Name="txtDiskHealth" Text="--" Foreground="#238636" FontSize="11" FontWeight="Bold"/>
                    </StackPanel>
                </Border>
                
                <!-- BitLocker -->
                <Border Background="#21262d" CornerRadius="6" Padding="12,6" Margin="0,0,0,0">
                    <StackPanel Orientation="Horizontal">
                        <TextBlock Text="[B]" Foreground="#8b949e" FontSize="11" FontWeight="Bold" Margin="0,0,6,0"/>
                        <TextBlock Text="BitLocker " Foreground="#8b949e" FontSize="11"/>
                        <TextBlock Name="txtBitLocker" Text="--" Foreground="#c9d1d9" FontSize="11" FontWeight="Bold"/>
                    </StackPanel>
                </Border>
            </WrapPanel>
        </Border>
        
        <!-- TABS: Tools primero, Apps segundo, Tweaks tercero -->
        <TabControl Grid.Row="2" Background="Transparent" BorderThickness="0" Margin="10">
            
            <!-- TAB: HERRAMIENTAS (Primero) -->
            <TabItem Header="Herramientas" Style="{StaticResource ModernTab}">
                <ScrollViewer VerticalScrollBarVisibility="Auto" Margin="10">
                    <WrapPanel Name="toolsPanel">
                        
                        <!-- Chris Titus WinUtil -->
                        <Border Style="{StaticResource ToolCard}" Width="280">
                            <StackPanel>
                                <TextBlock Text="Chris Titus WinUtil" FontSize="15" FontWeight="Bold" Foreground="#c9d1d9"/>
                                <TextBlock Text="Optimizacion completa de Windows, debloat y tweaks" 
                                           FontSize="11" Foreground="#8b949e" TextWrapping="Wrap" Margin="0,5,0,12"/>
                                <Button Name="btnTitus" Content="Ejecutar" Style="{StaticResource ModernButton}"/>
                            </StackPanel>
                        </Border>
                        
                        <!-- ITT - Install Tweaks Tool -->
                        <Border Style="{StaticResource ToolCard}" Width="280">
                            <StackPanel>
                                <TextBlock Text="IT-Tea Tool (ITT)" FontSize="15" FontWeight="Bold" Foreground="#c9d1d9"/>
                                <TextBlock Text="Herramienta de limpieza ligera" 
                                           FontSize="11" Foreground="#8b949e" TextWrapping="Wrap" Margin="0,5,0,12"/>
                                <Button Name="btnITT" Content="Ejecutar" Style="{StaticResource ModernButton}"/>
                            </StackPanel>
                        </Border>
                        
                        <!-- Microsoft Activation -->
                        <Border Style="{StaticResource ToolCard}" Width="280">
                            <StackPanel>
                                <TextBlock Text="Microsoft Activation (MAS)" FontSize="15" FontWeight="Bold" Foreground="#c9d1d9"/>
                                <TextBlock Text="Activacion HWID de Windows y Office" 
                                           FontSize="11" Foreground="#8b949e" TextWrapping="Wrap" Margin="0,5,0,12"/>
                                <Button Name="btnMAS" Content="Ejecutar" Style="{StaticResource ModernButton}"/>
                            </StackPanel>
                        </Border>
                        
                        <!-- Deep Repair -->
                        <Border Style="{StaticResource ToolCard}" Width="280">
                            <StackPanel>
                                <TextBlock Text="Reparacion Profunda" FontSize="15" FontWeight="Bold" Foreground="#c9d1d9"/>
                                <TextBlock Text="DISM + SFC + Limpieza de drivers" 
                                           FontSize="11" Foreground="#8b949e" TextWrapping="Wrap" Margin="0,5,0,12"/>
                                <Button Name="btnRepair" Content="Ejecutar" Style="{StaticResource ModernButton}"/>
                            </StackPanel>
                        </Border>
                        
                        <!-- Network Doctor -->
                        <Border Style="{StaticResource ToolCard}" Width="280">
                            <StackPanel>
                                <TextBlock Text="Doctor de Red" FontSize="15" FontWeight="Bold" Foreground="#c9d1d9"/>
                                <TextBlock Text="Resetear DNS, Winsock y TCP/IP" 
                                           FontSize="11" Foreground="#8b949e" TextWrapping="Wrap" Margin="0,5,0,12"/>
                                <Button Name="btnNetwork" Content="Ejecutar" Style="{StaticResource ModernButton}"/>
                            </StackPanel>
                        </Border>
                        
                        <!-- LTSC Recovery -->
                        <Border Style="{StaticResource ToolCard}" Width="280">
                            <StackPanel>
                                <TextBlock Text="Recuperacion LTSC" FontSize="15" FontWeight="Bold" Foreground="#c9d1d9"/>
                                <TextBlock Text="Recuperar Microsoft Store y Media Player" 
                                           FontSize="11" Foreground="#8b949e" TextWrapping="Wrap" Margin="0,5,0,12"/>
                                <Button Name="btnLTSC" Content="Ejecutar" Style="{StaticResource ModernButton}"/>
                            </StackPanel>
                        </Border>
                        
                    </WrapPanel>
                </ScrollViewer>
            </TabItem>
            
            <!-- TAB: APLICACIONES (Segundo) -->
            <TabItem Header="Aplicaciones" Style="{StaticResource ModernTab}">
                <Grid Margin="10">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>
                    
                    <!-- Botones de categoria -->
                    <StackPanel Grid.Row="0" Margin="0,0,0,10">
                        <WrapPanel Margin="0,0,0,8">
                            <Button Name="btnCatAll" Content="Todas" Style="{StaticResource SecondaryButton}" Margin="0,0,5,5"/>
                            <Button Name="btnCatBrowsers" Content="Navegadores" Style="{StaticResource SecondaryButton}" Margin="0,0,5,5"/>
                            <Button Name="btnCatMedia" Content="Multimedia" Style="{StaticResource SecondaryButton}" Margin="0,0,5,5"/>
                            <Button Name="btnCatGaming" Content="Gaming" Style="{StaticResource SecondaryButton}" Margin="0,0,5,5"/>
                            <Button Name="btnCatDev" Content="Desarrollo" Style="{StaticResource SecondaryButton}" Margin="0,0,5,5"/>
                            <Button Name="btnCatComm" Content="Comunicacion" Style="{StaticResource SecondaryButton}" Margin="0,0,5,5"/>
                            <Button Name="btnCatUtils" Content="Utilidades" Style="{StaticResource SecondaryButton}" Margin="0,0,5,5"/>
                        </WrapPanel>
                        <WrapPanel>
                            <Button Name="btnPresetEssential" Content="Pack Esencial" Style="{StaticResource ModernButton}" Margin="0,0,5,0" ToolTip="Chrome, AIMP, VLC, qBittorrent, Gaming Libs, WinRAR"/>
                            <Button Name="btnPresetDev" Content="Pack Programador" Style="{StaticResource ModernButton}" Margin="0,0,5,0" Background="#a371f7" ToolTip="VS Code, Git, Python, Node.js, Docker"/>
                            <Button Name="btnSelectAll" Content="Seleccionar Todo" Style="{StaticResource SecondaryButton}" Margin="10,0,5,0"/>
                            <Button Name="btnDeselectAll" Content="Deseleccionar" Style="{StaticResource SecondaryButton}" Margin="0,0,15,0"/>
                            <Border Background="#21262d" CornerRadius="5" Padding="8,5">
                                <StackPanel Orientation="Horizontal">
                                    <TextBlock Text="Gestor: " Foreground="#8b949e" VerticalAlignment="Center"/>
                                    <RadioButton Name="rbWinget" Content="Winget" Foreground="#c9d1d9" GroupName="pkgMgr" IsChecked="True" Margin="0,0,10,0"/>
                                    <RadioButton Name="rbChoco" Content="Chocolatey" Foreground="#c9d1d9" GroupName="pkgMgr"/>
                                </StackPanel>
                            </Border>
                        </WrapPanel>
                    </StackPanel>
                    
                    <!-- Lista de apps -->
                    <ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto">
                        <ItemsControl Name="appsListBox">
                            <ItemsControl.ItemsPanel>
                                <ItemsPanelTemplate>
                                    <WrapPanel ItemWidth="230"/>
                                </ItemsPanelTemplate>
                            </ItemsControl.ItemsPanel>
                        </ItemsControl>
                    </ScrollViewer>
                    
                    <!-- Boton instalar -->
                    <StackPanel Grid.Row="2" Orientation="Horizontal" HorizontalAlignment="Right" Margin="0,10,0,0">
                        <Button Name="btnInstallApps" Content="Instalar Seleccionadas" Style="{StaticResource ModernButton}" Padding="25,10"/>
                    </StackPanel>
                </Grid>
            </TabItem>
            
            <!-- TAB: TWEAKS (Tercero) -->
            <TabItem Header="Tweaks" Style="{StaticResource ModernTab}">
                <ScrollViewer Margin="10">
                    <StackPanel>
                        <TextBlock Text="Optimizaciones del Sistema (Chris Titus / ITT)" FontSize="16" FontWeight="Bold" Foreground="#58a6ff" Margin="0,0,0,15"/>
                        
                        <!-- Rendimiento -->
                        <Border Background="#161b22" CornerRadius="8" Padding="15" Margin="0,0,0,10">
                            <StackPanel>
                                <TextBlock Text="Rendimiento" FontSize="13" FontWeight="SemiBold" Foreground="#238636" Margin="0,0,0,10"/>
                                <CheckBox Name="chkTelemetry" Content="Deshabilitar Telemetria de Windows" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkCortana" Content="Deshabilitar Cortana" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkGameBar" Content="Deshabilitar Xbox GameBar y DVR" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkPerformance" Content="Plan de Energia: Rendimiento Maximo" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkPrefetch" Content="Optimizar Prefetch y Superfetch" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkIndexing" Content="Deshabilitar Indexacion de Busqueda" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkFastStartup" Content="Deshabilitar Inicio Rapido (mejor hibernacion)" Foreground="#c9d1d9" Margin="0,3"/>
                            </StackPanel>
                        </Border>
                        
                        <!-- Privacidad -->
                        <Border Background="#161b22" CornerRadius="8" Padding="15" Margin="0,0,0,10">
                            <StackPanel>
                                <TextBlock Text="Privacidad" FontSize="13" FontWeight="SemiBold" Foreground="#a371f7" Margin="0,0,0,10"/>
                                <CheckBox Name="chkActivity" Content="Deshabilitar Historial de Actividad" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkLocation" Content="Deshabilitar Ubicacion" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkAdId" Content="Deshabilitar ID de Publicidad" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkDiagnostics" Content="Minimizar Datos de Diagnostico" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkTailoredExp" Content="Deshabilitar Experiencias Personalizadas" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkClipboard" Content="Deshabilitar Historial de Portapapeles" Foreground="#c9d1d9" Margin="0,3"/>
                            </StackPanel>
                        </Border>
                        
                        <!-- Visual -->
                        <Border Background="#161b22" CornerRadius="8" Padding="15" Margin="0,0,0,10">
                            <StackPanel>
                                <TextBlock Text="Visual" FontSize="13" FontWeight="SemiBold" Foreground="#58a6ff" Margin="0,0,0,10"/>
                                <CheckBox Name="chkDarkMode" Content="Activar Modo Oscuro" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkTransparency" Content="Deshabilitar Efectos de Transparencia" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkAnimations" Content="Deshabilitar Animaciones de Ventanas" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkShowExt" Content="Mostrar Extensiones de Archivo" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkHiddenFiles" Content="Mostrar Archivos Ocultos" Foreground="#c9d1d9" Margin="0,3"/>
                            </StackPanel>
                        </Border>
                        
                        <!-- Servicios -->
                        <Border Background="#161b22" CornerRadius="8" Padding="15" Margin="0,0,0,10">
                            <StackPanel>
                                <TextBlock Text="Servicios (Avanzado)" FontSize="13" FontWeight="SemiBold" Foreground="#f0883e" Margin="0,0,0,10"/>
                                <CheckBox Name="chkPrintSpooler" Content="Deshabilitar Print Spooler (si no usas impresora)" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkFax" Content="Deshabilitar Servicio de Fax" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkRemoteReg" Content="Deshabilitar Registro Remoto" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkOneDrive" Content="Deshabilitar OneDrive" Foreground="#c9d1d9" Margin="0,3"/>
                            </StackPanel>
                        </Border>
                        
                        <!-- Limpieza -->
                        <Border Background="#161b22" CornerRadius="8" Padding="15" Margin="0,0,0,10">
                            <StackPanel>
                                <TextBlock Text="Limpieza" FontSize="13" FontWeight="SemiBold" Foreground="#f85149" Margin="0,0,0,10"/>
                                <CheckBox Name="chkTempFiles" Content="Limpiar Archivos Temporales" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkRecycleBin" Content="Vaciar Papelera de Reciclaje" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkPrefetchClean" Content="Limpiar Prefetch" Foreground="#c9d1d9" Margin="0,3"/>
                            </StackPanel>
                        </Border>
                        
                        <StackPanel Orientation="Horizontal" Margin="0,10,0,0">
                            <Button Name="btnApplyTweaks" Content="Aplicar Tweaks Seleccionados" Style="{StaticResource ModernButton}"/>
                            <Button Name="btnSelectAllTweaks" Content="Seleccionar Todos" Style="{StaticResource SecondaryButton}" Margin="10,0,0,0"/>
                        </StackPanel>
                    </StackPanel>
                </ScrollViewer>
            </TabItem>
            
            <!-- TAB: CONFIGURACION -->
            <TabItem Header="Configuracion" Style="{StaticResource ModernTab}">
                <ScrollViewer Margin="20">
                    <StackPanel>
                        <TextBlock Text="Configuracion del Panel" FontSize="16" FontWeight="Bold" Foreground="#58a6ff" Margin="0,0,0,20"/>
                        
                        <!-- Info del Panel -->
                        <Border Background="#161b22" CornerRadius="8" Padding="20" Margin="0,0,0,15">
                            <StackPanel>
                                <TextBlock Text="Acerca de" FontSize="13" FontWeight="SemiBold" Foreground="#c9d1d9" Margin="0,0,0,10"/>
                                <TextBlock Text="John Barzola Xtreme Panel" Foreground="#c9d1d9" FontSize="14"/>
                                <TextBlock Text="Version 12.0 - CYBER-CORE" Foreground="#8b949e" Margin="0,5,0,0"/>
                                <TextBlock Text="Desarrollado con PowerShell + WPF" Foreground="#8b949e"/>
                                <TextBlock Name="txtUserInfo" Text="Usuario actual: --" Foreground="#8b949e" Margin="0,10,0,0"/>
                            </StackPanel>
                        </Border>
                        
                        <!-- Info del Sistema -->
                        <Border Background="#161b22" CornerRadius="8" Padding="20" Margin="0,0,0,15">
                            <StackPanel>
                                <TextBlock Text="Informacion del Sistema" FontSize="13" FontWeight="SemiBold" Foreground="#c9d1d9" Margin="0,0,0,10"/>
                                <TextBlock Name="txtSysInfo" Text="Cargando..." Foreground="#8b949e" FontFamily="Consolas" FontSize="11"/>
                            </StackPanel>
                        </Border>
                        
                        <!-- Logs -->
                        <Border Background="#161b22" CornerRadius="8" Padding="20" Margin="0,0,0,15">
                            <StackPanel>
                                <StackPanel Orientation="Horizontal" Margin="0,0,0,10">
                                    <TextBlock Text="Registro de Actividades" FontSize="13" FontWeight="SemiBold" Foreground="#c9d1d9"/>
                                    <Button Name="btnClearLogs" Content="Limpiar" Style="{StaticResource SecondaryButton}" 
                                            Margin="15,0,0,0" Padding="10,3" FontSize="10"/>
                                </StackPanel>
                                <Border Background="#0d1117" CornerRadius="5" Padding="10" MaxHeight="200">
                                    <ScrollViewer VerticalScrollBarVisibility="Auto">
                                        <TextBlock Name="txtLogs" Text="[Inicio de sesion]" Foreground="#8b949e" 
                                                   FontFamily="Consolas" FontSize="10" TextWrapping="Wrap"/>
                                    </ScrollViewer>
                                </Border>
                            </StackPanel>
                        </Border>
                        
                        <!-- Enlaces -->
                        <Border Background="#161b22" CornerRadius="8" Padding="20">
                            <StackPanel>
                                <TextBlock Text="Enlaces" FontSize="13" FontWeight="SemiBold" Foreground="#c9d1d9" Margin="0,0,0,10"/>
                                <StackPanel Orientation="Horizontal">
                                    <Button Name="btnGitHub" Content="Ver en GitHub" Style="{StaticResource SecondaryButton}"/>
                                    <Button Name="btnExportLogs" Content="Exportar Logs" Style="{StaticResource SecondaryButton}" Margin="10,0,0,0"/>
                                </StackPanel>
                            </StackPanel>
                        </Border>
                    </StackPanel>
                </ScrollViewer>
            </TabItem>
        </TabControl>
        
        <!-- BARRA DE ESTADO -->
        <Border Grid.Row="3" Background="#161b22" Padding="15,10">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="Auto"/>
                </Grid.ColumnDefinitions>
                
                <StackPanel Grid.Column="0" Orientation="Horizontal">
                    <TextBlock Name="txtStatus" Text="Listo" Foreground="#8b949e" VerticalAlignment="Center"/>
                    <ProgressBar Name="progressBar" Width="250" Height="6" Margin="15,0,0,0" 
                                 Background="#21262d" Foreground="#238636" Value="0" Visibility="Collapsed"/>
                </StackPanel>
                
                <Button Grid.Column="1" Name="btnExit" Content="Salir" Style="{StaticResource SecondaryButton}"/>
            </Grid>
        </Border>
    </Grid>
</Window>
"@

    $reader = New-Object System.Xml.XmlNodeReader $xaml
    $window = [Windows.Markup.XamlReader]::Load($reader)
    
    # --- OBTENER CONTROLES ---
    $txtWelcome = $window.FindName("txtWelcome")
    $txtStatus = $window.FindName("txtStatus")
    $progressBar = $window.FindName("progressBar")
    $appsListBox = $window.FindName("appsListBox")
    $txtUserInfo = $window.FindName("txtUserInfo")
    
    # Monitoreo
    $txtRAM = $window.FindName("txtRAM")
    $txtCPU = $window.FindName("txtCPU")
    $txtCPUTemp = $window.FindName("txtCPUTemp")
    $txtGPU = $window.FindName("txtGPU")
    $txtGPUTemp = $window.FindName("txtGPUTemp")
    $txtDisk = $window.FindName("txtDisk")
    $txtDiskHealth = $window.FindName("txtDiskHealth")
    $txtBitLocker = $window.FindName("txtBitLocker")
    
    # Botones
    $btnTitus = $window.FindName("btnTitus")
    $btnITT = $window.FindName("btnITT")
    $btnMAS = $window.FindName("btnMAS")
    $btnRepair = $window.FindName("btnRepair")
    $btnNetwork = $window.FindName("btnNetwork")
    $btnLTSC = $window.FindName("btnLTSC")
    $btnInstallApps = $window.FindName("btnInstallApps")
    $btnApplyTweaks = $window.FindName("btnApplyTweaks")
    $btnSelectAllTweaks = $window.FindName("btnSelectAllTweaks")
    $btnGitHub = $window.FindName("btnGitHub")
    $btnExit = $window.FindName("btnExit")
    
    # Logs y configuracion
    $txtLogs = $window.FindName("txtLogs")
    $txtSysInfo = $window.FindName("txtSysInfo")
    $btnClearLogs = $window.FindName("btnClearLogs")
    $btnExportLogs = $window.FindName("btnExportLogs")
    
    # Categoria buttons
    $btnCatAll = $window.FindName("btnCatAll")
    $btnCatBrowsers = $window.FindName("btnCatBrowsers")
    $btnCatMedia = $window.FindName("btnCatMedia")
    $btnCatGaming = $window.FindName("btnCatGaming")
    $btnCatDev = $window.FindName("btnCatDev")
    $btnCatComm = $window.FindName("btnCatComm")
    $btnCatUtils = $window.FindName("btnCatUtils")
    $btnSelectAll = $window.FindName("btnSelectAll")
    $btnDeselectAll = $window.FindName("btnDeselectAll")
    
    # Preset buttons
    $btnPresetEssential = $window.FindName("btnPresetEssential")
    $btnPresetDev = $window.FindName("btnPresetDev")
    
    # Package manager
    $rbWinget = $window.FindName("rbWinget")
    $rbChoco = $window.FindName("rbChoco")
    
    # --- INICIALIZAR ---
    $txtWelcome.Text = "Bienvenido, $script:AuthenticatedUser"
    $txtUserInfo.Text = "Usuario actual: $script:AuthenticatedUser"
    
    # --- ACTUALIZAR MONITOREO ---
    function Update-SystemMonitor {
        try {
            # RAM
            $os = Get-CimInstance Win32_OperatingSystem
            $totalRAM = [math]::Round($os.TotalVisibleMemorySize / 1MB, 1)
            $freeRAM = [math]::Round($os.FreePhysicalMemory / 1MB, 1)
            $usedRAM = $totalRAM - $freeRAM
            $ramPercent = [math]::Round(($usedRAM / $totalRAM) * 100)
            $txtRAM.Text = "$usedRAM/$totalRAM GB ($ramPercent%)"
            
            # Color RAM segun uso
            if ($ramPercent -gt 85) { $txtRAM.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#f85149") }
            elseif ($ramPercent -gt 70) { $txtRAM.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#f0883e") }
            else { $txtRAM.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#58a6ff") }
            
            # CPU uso
            $cpuLoad = (Get-CimInstance Win32_Processor).LoadPercentage
            if ($null -eq $cpuLoad) { $cpuLoad = 0 }
            $txtCPU.Text = "$cpuLoad%"
            
            # Color CPU segun uso
            if ($cpuLoad -gt 85) { $txtCPU.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#f85149") }
            elseif ($cpuLoad -gt 60) { $txtCPU.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#f0883e") }
            else { $txtCPU.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#238636") }
            
            # CPU temperatura
            $cpuTemp = $null
            try {
                $thermalZone = Get-CimInstance -Namespace "root/WMI" -ClassName "MSAcpi_ThermalZoneTemperature" -ErrorAction SilentlyContinue | Select-Object -First 1
                if ($thermalZone) {
                    $cpuTemp = [math]::Round(($thermalZone.CurrentTemperature - 2732) / 10)
                }
            }
            catch {}
            
            if ($cpuTemp) {
                $txtCPUTemp.Text = "${cpuTemp}C"
                if ($cpuTemp -gt 80) { $txtCPUTemp.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#f85149") }
                elseif ($cpuTemp -gt 65) { $txtCPUTemp.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#f0883e") }
                else { $txtCPUTemp.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#238636") }
            }
            else {
                $txtCPUTemp.Text = "N/A"
                $txtCPUTemp.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#8b949e")
            }
            
            # GPU uso % (via performance counter si disponible)
            $gpuUsage = $null
            try {
                $gpuCounter = Get-Counter '\GPU Engine(*engtype_3D)\Utilization Percentage' -ErrorAction SilentlyContinue
                if ($gpuCounter) {
                    $gpuUsage = [math]::Round(($gpuCounter.CounterSamples | Measure-Object -Property CookedValue -Sum).Sum, 0)
                }
            }
            catch {}
            
            if ($gpuUsage -ne $null) {
                $txtGPU.Text = "$gpuUsage%"
            }
            else {
                $txtGPU.Text = "N/A"
            }
            $txtGPU.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#a371f7")
            
            # GPU temperatura (puede ser igual a CPU temp en sistemas integrados)
            $gpuTemp = $null
            try {
                # Intentar obtener temp GPU especifica
                $videoTemp = Get-CimInstance -Namespace "root/WMI" -ClassName "MSAcpi_ThermalZoneTemperature" -ErrorAction SilentlyContinue | 
                Select-Object -Last 1
                if ($videoTemp) {
                    $gpuTemp = [math]::Round(($videoTemp.CurrentTemperature - 2732) / 10)
                }
            }
            catch {}
            
            if ($gpuTemp) {
                $txtGPUTemp.Text = "${gpuTemp}C"
                if ($gpuTemp -gt 80) { $txtGPUTemp.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#f85149") }
                elseif ($gpuTemp -gt 65) { $txtGPUTemp.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#f0883e") }
                else { $txtGPUTemp.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#238636") }
            }
            else {
                $txtGPUTemp.Text = "N/A"
                $txtGPUTemp.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#8b949e")
            }
            
            # Disco
            $disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
            $freeGB = [math]::Round($disk.FreeSpace / 1GB)
            $totalGB = [math]::Round($disk.Size / 1GB)
            $usedPercent = [math]::Round((($totalGB - $freeGB) / $totalGB) * 100)
            $txtDisk.Text = "$freeGB/$totalGB GB"
            
            if ($usedPercent -gt 90) { $txtDisk.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#f85149") }
            elseif ($usedPercent -gt 75) { $txtDisk.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#f0883e") }
            else { $txtDisk.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#238636") }
            
            # Salud del disco SMART
            $healthStatus = "Saludable"
            $healthPercent = 100
            try {
                $diskDrive = Get-CimInstance Win32_DiskDrive | Where-Object { $_.DeviceID -like "*PHYSICALDRIVE0*" } | Select-Object -First 1
                if ($diskDrive) {
                    # Intentar obtener SMART via CIM (si disponible)
                    $smartData = Get-CimInstance -Namespace "root\wmi" -ClassName "MSStorageDriver_FailurePredictStatus" -ErrorAction SilentlyContinue | Select-Object -First 1
                    if ($smartData -and $smartData.PredictFailure) {
                        $healthStatus = "Critico"
                        $healthPercent = 0
                    }
                    elseif ($diskDrive.Status -ne "OK") {
                        $healthStatus = "Precaucion"
                        $healthPercent = 50
                    }
                }
            }
            catch {}
            
            $txtDiskHealth.Text = "$healthStatus ($healthPercent%)"
            if ($healthStatus -eq "Critico") { 
                $txtDiskHealth.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#f85149") 
            }
            elseif ($healthStatus -eq "Precaucion") { 
                $txtDiskHealth.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#f0883e") 
            }
            else { 
                $txtDiskHealth.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#238636") 
            }
            
            # BitLocker
            try {
                $bl = Get-BitLockerVolume -MountPoint "C:" -ErrorAction SilentlyContinue
                if ($bl.ProtectionStatus -eq "On") { 
                    $txtBitLocker.Text = "Activo"
                    $txtBitLocker.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#238636")
                }
                else { 
                    $txtBitLocker.Text = "Inactivo"
                    $txtBitLocker.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#8b949e")
                }
            }
            catch { 
                $txtBitLocker.Text = "N/A" 
                $txtBitLocker.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#8b949e")
            }
        }
        catch {
            # Ignorar errores de monitoreo
        }
    }
    
    # Actualizar monitoreo inicial
    Update-SystemMonitor
    
    # --- AUTO-REFRESH CADA 2 SEGUNDOS ---
    $timer = New-Object System.Windows.Threading.DispatcherTimer
    $timer.Interval = [TimeSpan]::FromSeconds(2)
    $timer.Add_Tick({ Update-SystemMonitor })
    $timer.Start()
    
    # --- SISTEMA DE LOGS ---
    $script:LogEntries = @()
    
    function Add-Log {
        param([string]$Action)
        $time = Get-Date -Format "HH:mm:ss"
        $entry = "[$time] $Action"
        $script:LogEntries += $entry
        $txtLogs.Text = ($script:LogEntries -join "`n")
    }
    
    # Log inicial
    Add-Log "Sesion iniciada por $script:AuthenticatedUser"
    
    # System Info
    $cpu = (Get-CimInstance Win32_Processor).Name
    $ramTotal = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 1)
    $os = (Get-CimInstance Win32_OperatingSystem).Caption
    $pcName = $env:COMPUTERNAME
    $txtSysInfo.Text = "PC: $pcName`nOS: $os`nCPU: $cpu`nRAM: $ramTotal GB"
    
    # Botones de logs
    $btnClearLogs.Add_Click({
            $script:LogEntries = @()
            $txtLogs.Text = "[Logs limpiados]"
            Add-Log "Logs limpiados"
        })
    
    $btnExportLogs.Add_Click({
            $logPath = "$env:USERPROFILE\Desktop\ChrisExtreme_Logs_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
            $header = "=== CHRIS EXTREME PANEL - Registro de Actividades ===`n"
            $header += "Usuario: $script:AuthenticatedUser`n"
            $header += "Fecha: $(Get-Date)`n"
            $header += "PC: $env:COMPUTERNAME`n"
            $header += "============================================`n`n"
            ($header + ($script:LogEntries -join "`n")) | Out-File $logPath -Encoding UTF8
            Add-Log "Logs exportados a: $logPath"
            [System.Windows.MessageBox]::Show("Logs exportados a:`n$logPath", "Exportar", "OK", "Information")
        })
    
    # --- ALMACENAR CHECKBOXES ---
    $script:appCheckboxes = @{}
    
    # --- CARGAR APLICACIONES ---
    function Initialize-AppsList {
        param([string]$Filter = "Todas")
        
        $appsListBox.Items.Clear()
        $script:appCheckboxes.Clear()
        
        foreach ($category in $script:AppCategories.Keys) {
            if ($Filter -ne "Todas" -and $category -ne $Filter) { continue }
            
            # Contenedor de categoria
            $catContainer = New-Object System.Windows.Controls.StackPanel
            $catContainer.Margin = [System.Windows.Thickness]::new(0, 10, 0, 5)
            
            # Header de categoria
            $catHeader = New-Object System.Windows.Controls.TextBlock
            $catHeader.Text = $category
            $catHeader.FontSize = 14
            $catHeader.FontWeight = "Bold"
            $catHeader.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#58a6ff")
            $catHeader.Margin = [System.Windows.Thickness]::new(5, 0, 5, 8)
            [void]$catContainer.Children.Add($catHeader)
            
            # WrapPanel para apps de esta categoria
            $appsWrap = New-Object System.Windows.Controls.WrapPanel
            
            foreach ($app in $script:AppCategories[$category]) {
                $border = New-Object System.Windows.Controls.Border
                $border.Background = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#21262d")
                $border.CornerRadius = [System.Windows.CornerRadius]::new(5)
                $border.Padding = [System.Windows.Thickness]::new(10, 8, 10, 8)
                $border.Margin = [System.Windows.Thickness]::new(3)
                $border.Width = 200
                
                $stack = New-Object System.Windows.Controls.StackPanel
                $stack.Orientation = "Horizontal"
                
                $cb = New-Object System.Windows.Controls.CheckBox
                $cb.VerticalAlignment = "Center"
                $cb.Tag = $app.Id
                
                $lbl = New-Object System.Windows.Controls.TextBlock
                $lbl.Text = $app.Name
                $lbl.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#c9d1d9")
                $lbl.Margin = [System.Windows.Thickness]::new(8, 0, 0, 0)
                $lbl.VerticalAlignment = "Center"
                $lbl.FontSize = 11
                
                [void]$stack.Children.Add($cb)
                [void]$stack.Children.Add($lbl)
                $border.Child = $stack
                
                [void]$appsWrap.Children.Add($border)
                $script:appCheckboxes[$app.Id] = $cb
            }
            
            [void]$catContainer.Children.Add($appsWrap)
            [void]$appsListBox.Items.Add($catContainer)
        }
    }
    
    # Cargar apps inicialmente
    Initialize-AppsList -Filter "Todas"
    
    # --- EVENTOS CATEGORIA ---
    $btnCatAll.Add_Click({ Initialize-AppsList -Filter "Todas" })
    $btnCatBrowsers.Add_Click({ Initialize-AppsList -Filter "Navegadores" })
    $btnCatMedia.Add_Click({ Initialize-AppsList -Filter "Multimedia" })
    $btnCatGaming.Add_Click({ Initialize-AppsList -Filter "Librerias Gaming" })
    $btnCatDev.Add_Click({ Initialize-AppsList -Filter "Desarrollo" })
    $btnCatComm.Add_Click({ Initialize-AppsList -Filter "Comunicacion" })
    $btnCatUtils.Add_Click({ Initialize-AppsList -Filter "Utilidades" })
    
    $btnSelectAll.Add_Click({
            foreach ($cb in $script:appCheckboxes.Values) { $cb.IsChecked = $true }
        })
    
    $btnDeselectAll.Add_Click({
            foreach ($cb in $script:appCheckboxes.Values) { $cb.IsChecked = $false }
        })
    
    # Pack Esencial: VLC, AIMP, Chrome, VC++ todas, WinRAR, XNA, DirectX, .NET 8
    $btnPresetEssential.Add_Click({
            foreach ($cb in $script:appCheckboxes.Values) { $cb.IsChecked = $false }
            $essentialIds = @(
                "VideoLAN.VLC", "AIMP.AIMP", "Google.Chrome", "RARLab.WinRAR",
                "Microsoft.DirectX", "Microsoft.XNARedist", "Microsoft.DotNet.DesktopRuntime.8",
                "Microsoft.VCRedist.2005.x64", "Microsoft.VCRedist.2008.x64", 
                "Microsoft.VCRedist.2010.x64", "Microsoft.VCRedist.2012.x64",
                "Microsoft.VCRedist.2013.x64", "Microsoft.VCRedist.2015+.x64"
            )
            foreach ($id in $essentialIds) {
                if ($script:appCheckboxes.ContainsKey($id)) { $script:appCheckboxes[$id].IsChecked = $true }
            }
            Add-Log "Pack Esencial seleccionado"
            Set-Status "Pack Esencial seleccionado"
        })
    
    # Pack Programador: Todos los apps de la categoria Desarrollo
    $btnPresetDev.Add_Click({
            foreach ($cb in $script:appCheckboxes.Values) { $cb.IsChecked = $false }
            # Seleccionar todos los de Desarrollo
            foreach ($app in $script:AppCategories["Desarrollo"]) {
                if ($script:appCheckboxes.ContainsKey($app.Id)) { 
                    $script:appCheckboxes[$app.Id].IsChecked = $true 
                }
            }
            Add-Log "Pack Programador seleccionado"
            Set-Status "Pack Programador seleccionado"
        })
    
    # --- FUNCION ACTUALIZAR STATUS ---
    function Set-Status {
        param([string]$Message)
        $txtStatus.Text = $Message
        $window.Dispatcher.Invoke([Action] {}, "Render")
    }
    
    # --- INSTALAR APPS ---
    $btnInstallApps.Add_Click({
            $selected = $script:appCheckboxes.GetEnumerator() | Where-Object { $_.Value.IsChecked -eq $true }
        
            if ($selected.Count -eq 0) {
                [System.Windows.MessageBox]::Show("Selecciona al menos una aplicacion.", "Sin seleccion", "OK", "Information")
                return
            }
        
            $useChoco = $rbChoco.IsChecked
            $progressBar.Visibility = "Visible"
            $progressBar.Maximum = $selected.Count
            $progressBar.Value = 0
        
            $count = 0
            $failed = @()
            foreach ($app in $selected) {
                $count++
                $mgr = if ($useChoco) { "Chocolatey" } else { "Winget" }
                Set-Status "[$mgr] Instalando: $($app.Key) ($count/$($selected.Count))"
                $progressBar.Value = $count
            
                try {
                    if ($useChoco) {
                        # Chocolatey - el ID puede ser diferente, usamos nombre similar
                        $chocoName = ($app.Key -split '\.')[-1].ToLower()
                        Start-Process -FilePath "choco" -ArgumentList "install $chocoName -y" -Wait -NoNewWindow -ErrorAction Stop
                    }
                    else {
                        # Winget
                        $exitCode = (Start-Process -FilePath "winget" -ArgumentList "install -e --id $($app.Key) --accept-package-agreements --accept-source-agreements --silent" -Wait -PassThru -NoNewWindow).ExitCode
                        if ($exitCode -ne 0) { $failed += $app.Key }
                    }
                }
                catch {
                    $failed += $app.Key
                }
            }
        
            $progressBar.Visibility = "Collapsed"
        
            if ($failed.Count -gt 0) {
                $altMgr = if ($useChoco) { "Winget" } else { "Chocolatey" }
                $failedList = $failed -join "`n"
                $msg = "Se instalaron $($count - $failed.Count) aplicaciones.`n`nFallaron ($($failed.Count)):`n$failedList`n`nSugerencia: Intenta instalar las fallidas con $altMgr"
                [System.Windows.MessageBox]::Show($msg, "Completado con errores", "OK", "Warning")
            }
            else {
                [System.Windows.MessageBox]::Show("Se instalaron $count aplicaciones correctamente.", "Completado", "OK", "Information")
            }
            Set-Status "Instalacion completada"
        })
    
    # --- EVENTOS HERRAMIENTAS ---
    $btnTitus.Add_Click({
            Set-Status "Ejecutando Chris Titus WinUtil..."
            Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://christitus.com/win | iex`"" -Verb RunAs
        })
    
    $btnITT.Add_Click({
            Set-Status "Ejecutando IT-Tea Tool..."
            Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://raw.githubusercontent.com/emadadeldev/ittea/main/itt.ps1 | iex`"" -Verb RunAs
        })
    
    $btnMAS.Add_Click({
            Set-Status "Ejecutando Microsoft Activation Scripts..."
            Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://get.activated.win | iex`"" -Verb RunAs
        })
    
    $btnRepair.Add_Click({
            $result = [System.Windows.MessageBox]::Show("Esto ejecutara DISM y SFC. Continuar?", "Reparacion Profunda", "YesNo", "Question")
            if ($result -eq "Yes") {
                Set-Status "Ejecutando reparacion del sistema..."
                dism /Online /Cleanup-Image /CheckHealth
                Set-Status "Verificando imagen del sistema..."
                $window.Dispatcher.Invoke([Action] {}, "Render")
                dism /Online /Cleanup-Image /RestoreHealth
                Set-Status "Ejecutando SFC..."
                $window.Dispatcher.Invoke([Action] {}, "Render")
                sfc /scannow
                Set-Status "Reparacion completada"
                [System.Windows.MessageBox]::Show("Reparacion del sistema completada.", "Completado", "OK", "Information")
            }
        })
    
    $btnNetwork.Add_Click({
            $result = [System.Windows.MessageBox]::Show("Esto reseteara la configuracion de red. Continuar?", "Doctor de Red", "YesNo", "Question")
            if ($result -eq "Yes") {
                Set-Status "Limpiando cache DNS..."
                ipconfig /flushdns | Out-Null
                Set-Status "Reseteando Winsock..."
                $window.Dispatcher.Invoke([Action] {}, "Render")
                netsh winsock reset | Out-Null
                Set-Status "Reseteando TCP/IP..."
                $window.Dispatcher.Invoke([Action] {}, "Render")
                netsh int ip reset | Out-Null
                Set-Status "Red reseteada - Reinicio recomendado"
                [System.Windows.MessageBox]::Show("Configuracion de red reseteada. Se recomienda reiniciar.", "Completado", "OK", "Information")
            }
        })
    
    $btnLTSC.Add_Click({
            Set-Status "Ejecutando recuperacion LTSC..."
            $result = [System.Windows.MessageBox]::Show("Esto intentara recuperar la Microsoft Store. Puede tomar varios minutos. Continuar?", "Recuperacion LTSC", "YesNo", "Question")
            if ($result -eq "Yes") {
                wsreset -i
                Set-Status "Recuperacion iniciada - esperar 2-3 minutos"
                [System.Windows.MessageBox]::Show("La recuperacion de la Store se ha iniciado. Espera 2-3 minutos.", "En progreso", "OK", "Information")
            }
        })
    
    $btnHardware.Add_Click({
            Set-Status "Obteniendo informacion del hardware..."
            $cpu = (Get-CimInstance Win32_Processor).Name
            $ramTotal = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)
            $gpu = (Get-CimInstance Win32_VideoController).Name -join "`n"
            $disks = (Get-CimInstance Win32_DiskDrive | Where-Object { $_.MediaType -like "*fixed*" }).Model -join "`n"
        
            $info = @"
CPU: $cpu

RAM Total: $ramTotal GB

GPU:
$gpu

Discos:
$disks
"@
            [System.Windows.MessageBox]::Show($info, "Informacion del Hardware", "OK", "Information")
            Set-Status "Listo"
        })
    
    $btnApplyTweaks.Add_Click({
            Add-Log "Aplicando tweaks seleccionados..."
            [System.Windows.MessageBox]::Show("Funcionalidad completa de tweaks en desarrollo.`nPor ahora, usa Chris Titus WinUtil para aplicar optimizaciones avanzadas.", "Info", "OK", "Information")
        })
    
    $btnSelectAllTweaks.Add_Click({
            # Seleccionar todos los checkboxes de tweaks
            $tweakCheckboxes = @("chkTelemetry", "chkCortana", "chkGameBar", "chkPerformance", "chkPrefetch", 
                "chkIndexing", "chkFastStartup", "chkActivity", "chkLocation", "chkAdId",
                "chkDiagnostics", "chkTailoredExp", "chkClipboard", "chkDarkMode", "chkTransparency",
                "chkAnimations", "chkShowExt", "chkHiddenFiles", "chkPrintSpooler", "chkFax",
                "chkRemoteReg", "chkOneDrive", "chkTempFiles", "chkRecycleBin", "chkPrefetchClean")
            foreach ($name in $tweakCheckboxes) {
                $cb = $window.FindName($name)
                if ($cb) { $cb.IsChecked = $true }
            }
            Add-Log "Todos los tweaks seleccionados"
        })
    
    $btnGitHub.Add_Click({
            Add-Log "Abriendo GitHub"
            Start-Process "https://github.com/johnblack593/Script"
        })
    
    $btnExit.Add_Click({
            Add-Log "Sesion cerrada"
            $window.Close()
        })
    
    # Mostrar ventana
    $window.ShowDialog() | Out-Null
}

# ============================================================
# PUNTO DE ENTRADA
# ============================================================
$loginResult = Show-LoginWindow

if ($loginResult -eq $true) {
    Show-MainWindow
}
