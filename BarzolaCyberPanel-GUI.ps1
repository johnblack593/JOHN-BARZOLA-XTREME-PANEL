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
    Title="CYBER CORE - Acceso Seguro" 
    Height="350" Width="400"
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
                <TextBlock Text="CYBER CORE" FontSize="24" FontWeight="Bold" 
                           Foreground="#58a6ff" HorizontalAlignment="Center" Margin="0,0,0,5"/>
                <TextBlock Text="John Barzola Xtreme Panel" FontSize="12" 
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
                    <TextBlock Text="CYBER CORE" FontSize="22" FontWeight="Bold" Foreground="#58a6ff"/>
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
        <Border Grid.Row="1" Background="#0d1117" Padding="15,10" BorderBrush="#21262d" BorderThickness="0,0,0,1">
            <WrapPanel>
                <Border Background="#21262d" CornerRadius="5" Padding="10,5" Margin="0,0,10,0">
                    <StackPanel Orientation="Horizontal">
                        <TextBlock Text="RAM: " Foreground="#8b949e" FontSize="11"/>
                        <TextBlock Name="txtRAM" Text="--" Foreground="#58a6ff" FontSize="11" FontWeight="Bold"/>
                    </StackPanel>
                </Border>
                <Border Background="#21262d" CornerRadius="5" Padding="10,5" Margin="0,0,10,0">
                    <StackPanel Orientation="Horizontal">
                        <TextBlock Text="CPU: " Foreground="#8b949e" FontSize="11"/>
                        <TextBlock Name="txtCPU" Text="--" Foreground="#238636" FontSize="11" FontWeight="Bold"/>
                    </StackPanel>
                </Border>
                <Border Background="#21262d" CornerRadius="5" Padding="10,5" Margin="0,0,10,0">
                    <StackPanel Orientation="Horizontal">
                        <TextBlock Text="GPU: " Foreground="#8b949e" FontSize="11"/>
                        <TextBlock Name="txtGPU" Text="--" Foreground="#a371f7" FontSize="11" FontWeight="Bold"/>
                    </StackPanel>
                </Border>
                <Border Background="#21262d" CornerRadius="5" Padding="10,5" Margin="0,0,10,0">
                    <StackPanel Orientation="Horizontal">
                        <TextBlock Text="Disco: " Foreground="#8b949e" FontSize="11"/>
                        <TextBlock Name="txtDisk" Text="--" Foreground="#f0883e" FontSize="11" FontWeight="Bold"/>
                    </StackPanel>
                </Border>
                <Border Background="#21262d" CornerRadius="5" Padding="10,5" Margin="0,0,10,0">
                    <StackPanel Orientation="Horizontal">
                        <TextBlock Text="BitLocker: " Foreground="#8b949e" FontSize="11"/>
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
                        
                        <!-- Hardware Info -->
                        <Border Style="{StaticResource ToolCard}" Width="280">
                            <StackPanel>
                                <TextBlock Text="Info del Hardware" FontSize="15" FontWeight="Bold" Foreground="#c9d1d9"/>
                                <TextBlock Text="Ver detalles de CPU, RAM, GPU y disco" 
                                           FontSize="11" Foreground="#8b949e" TextWrapping="Wrap" Margin="0,5,0,12"/>
                                <Button Name="btnHardware" Content="Ver Info" Style="{StaticResource ModernButton}"/>
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
                    <WrapPanel Grid.Row="0" Margin="0,0,0,10">
                        <Button Name="btnCatAll" Content="Todas" Style="{StaticResource SecondaryButton}" Margin="0,0,5,5"/>
                        <Button Name="btnCatBrowsers" Content="Navegadores" Style="{StaticResource SecondaryButton}" Margin="0,0,5,5"/>
                        <Button Name="btnCatMedia" Content="Multimedia" Style="{StaticResource SecondaryButton}" Margin="0,0,5,5"/>
                        <Button Name="btnCatGaming" Content="Librerias Gaming" Style="{StaticResource SecondaryButton}" Margin="0,0,5,5"/>
                        <Button Name="btnCatDev" Content="Desarrollo" Style="{StaticResource SecondaryButton}" Margin="0,0,5,5"/>
                        <Button Name="btnCatComm" Content="Comunicacion" Style="{StaticResource SecondaryButton}" Margin="0,0,5,5"/>
                        <Button Name="btnCatUtils" Content="Utilidades" Style="{StaticResource SecondaryButton}" Margin="0,0,5,5"/>
                        <Button Name="btnSelectAll" Content="Seleccionar Todo" Style="{StaticResource ModernButton}" Margin="10,0,0,5"/>
                        <Button Name="btnDeselectAll" Content="Deseleccionar" Style="{StaticResource SecondaryButton}" Margin="5,0,0,5"/>
                    </WrapPanel>
                    
                    <!-- Lista de apps -->
                    <ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto">
                        <ItemsControl Name="appsListBox">
                            <ItemsControl.ItemsPanel>
                                <ItemsPanelTemplate>
                                    <WrapPanel/>
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
                        <TextBlock Text="Ajustes del Sistema" FontSize="16" FontWeight="Bold" Foreground="#58a6ff" Margin="0,0,0,15"/>
                        
                        <Border Background="#161b22" CornerRadius="8" Padding="15" Margin="0,0,0,10">
                            <StackPanel>
                                <TextBlock Text="Rendimiento" FontSize="13" FontWeight="SemiBold" Foreground="#c9d1d9" Margin="0,0,0,10"/>
                                <CheckBox Name="chkTelemetry" Content="Deshabilitar Telemetria" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkCortana" Content="Deshabilitar Cortana" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkGameBar" Content="Deshabilitar Xbox GameBar" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkPerformance" Content="Activar Modo Rendimiento Maximo" Foreground="#c9d1d9" Margin="0,3"/>
                            </StackPanel>
                        </Border>
                        
                        <Border Background="#161b22" CornerRadius="8" Padding="15" Margin="0,0,0,10">
                            <StackPanel>
                                <TextBlock Text="Privacidad" FontSize="13" FontWeight="SemiBold" Foreground="#c9d1d9" Margin="0,0,0,10"/>
                                <CheckBox Name="chkActivity" Content="Deshabilitar Historial de Actividad" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkLocation" Content="Deshabilitar Ubicacion" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkAdId" Content="Deshabilitar ID de Publicidad" Foreground="#c9d1d9" Margin="0,3"/>
                            </StackPanel>
                        </Border>
                        
                        <Border Background="#161b22" CornerRadius="8" Padding="15" Margin="0,0,0,10">
                            <StackPanel>
                                <TextBlock Text="Visual" FontSize="13" FontWeight="SemiBold" Foreground="#c9d1d9" Margin="0,0,0,10"/>
                                <CheckBox Name="chkDarkMode" Content="Activar Modo Oscuro" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkTransparency" Content="Deshabilitar Efectos de Transparencia" Foreground="#c9d1d9" Margin="0,3"/>
                                <CheckBox Name="chkAnimations" Content="Deshabilitar Animaciones" Foreground="#c9d1d9" Margin="0,3"/>
                            </StackPanel>
                        </Border>
                        
                        <Button Name="btnApplyTweaks" Content="Aplicar Tweaks Seleccionados" 
                                Style="{StaticResource ModernButton}" HorizontalAlignment="Left" Margin="0,10,0,0"/>
                    </StackPanel>
                </ScrollViewer>
            </TabItem>
            
            <!-- TAB: CONFIGURACION -->
            <TabItem Header="Configuracion" Style="{StaticResource ModernTab}">
                <StackPanel Margin="20">
                    <TextBlock Text="Acerca del Panel" FontSize="16" FontWeight="Bold" Foreground="#58a6ff" Margin="0,0,0,20"/>
                    
                    <Border Background="#161b22" CornerRadius="8" Padding="20" Margin="0,0,0,15">
                        <StackPanel>
                            <TextBlock Text="John Barzola Xtreme Panel" Foreground="#c9d1d9" FontSize="14"/>
                            <TextBlock Text="Version 12.0 - CYBER-CORE" Foreground="#8b949e" Margin="0,5,0,0"/>
                            <TextBlock Text="Desarrollado con PowerShell + WPF" Foreground="#8b949e"/>
                            <TextBlock Name="txtUserInfo" Text="Usuario actual: --" Foreground="#8b949e" Margin="0,10,0,0"/>
                        </StackPanel>
                    </Border>
                    
                    <Border Background="#161b22" CornerRadius="8" Padding="20">
                        <StackPanel>
                            <TextBlock Text="Enlaces" FontSize="13" FontWeight="SemiBold" Foreground="#c9d1d9" Margin="0,0,0,10"/>
                            <Button Name="btnGitHub" Content="Ver en GitHub" Style="{StaticResource SecondaryButton}" HorizontalAlignment="Left"/>
                        </StackPanel>
                    </Border>
                </StackPanel>
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
    $txtGPU = $window.FindName("txtGPU")
    $txtDisk = $window.FindName("txtDisk")
    $txtBitLocker = $window.FindName("txtBitLocker")
    
    # Botones
    $btnTitus = $window.FindName("btnTitus")
    $btnITT = $window.FindName("btnITT")
    $btnMAS = $window.FindName("btnMAS")
    $btnRepair = $window.FindName("btnRepair")
    $btnNetwork = $window.FindName("btnNetwork")
    $btnLTSC = $window.FindName("btnLTSC")
    $btnHardware = $window.FindName("btnHardware")
    $btnInstallApps = $window.FindName("btnInstallApps")
    $btnApplyTweaks = $window.FindName("btnApplyTweaks")
    $btnGitHub = $window.FindName("btnGitHub")
    $btnExit = $window.FindName("btnExit")
    
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
            
            # CPU (simplificado - uso actual de procesos)
            $cpuLoad = (Get-CimInstance Win32_Processor).LoadPercentage
            if ($null -eq $cpuLoad) { $cpuLoad = 0 }
            $txtCPU.Text = "$cpuLoad%"
            
            # GPU
            $gpu = (Get-CimInstance Win32_VideoController | Select-Object -First 1).Name
            if ($gpu.Length -gt 25) { $gpu = $gpu.Substring(0, 22) + "..." }
            $txtGPU.Text = $gpu
            
            # Disco
            $disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
            $freeGB = [math]::Round($disk.FreeSpace / 1GB)
            $totalGB = [math]::Round($disk.Size / 1GB)
            $txtDisk.Text = "$freeGB GB libres de $totalGB GB"
            
            # BitLocker
            try {
                $bl = Get-BitLockerVolume -MountPoint "C:" -ErrorAction SilentlyContinue
                if ($bl.ProtectionStatus -eq "On") { $txtBitLocker.Text = "Activo" }
                else { $txtBitLocker.Text = "Inactivo" }
            }
            catch { $txtBitLocker.Text = "N/A" }
        }
        catch {
            # Ignorar errores de monitoreo
        }
    }
    
    # Actualizar monitoreo inicial
    Update-SystemMonitor
    
    # --- ALMACENAR CHECKBOXES ---
    $script:appCheckboxes = @{}
    
    # --- CARGAR APLICACIONES ---
    function Initialize-AppsList {
        param([string]$Filter = "Todas")
        
        $appsListBox.Items.Clear()
        $script:appCheckboxes.Clear()
        
        foreach ($category in $script:AppCategories.Keys) {
            if ($Filter -ne "Todas" -and $category -ne $Filter) { continue }
            
            # Header de categoria
            $catHeader = New-Object System.Windows.Controls.TextBlock
            $catHeader.Text = $category
            $catHeader.FontSize = 14
            $catHeader.FontWeight = "Bold"
            $catHeader.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#58a6ff")
            $catHeader.Margin = [System.Windows.Thickness]::new(5, 15, 5, 5)
            $catHeader.Width = 1000
            [void]$appsListBox.Items.Add($catHeader)
            
            foreach ($app in $script:AppCategories[$category]) {
                $border = New-Object System.Windows.Controls.Border
                $border.Background = [System.Windows.Media.BrushConverter]::new().ConvertFrom("#21262d")
                $border.CornerRadius = [System.Windows.CornerRadius]::new(5)
                $border.Padding = [System.Windows.Thickness]::new(10, 8, 10, 8)
                $border.Margin = [System.Windows.Thickness]::new(3)
                $border.Width = 220
                
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
                $lbl.FontSize = 12
                
                [void]$stack.Children.Add($cb)
                [void]$stack.Children.Add($lbl)
                $border.Child = $stack
                
                [void]$appsListBox.Items.Add($border)
                $script:appCheckboxes[$app.Id] = $cb
            }
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
        
            $progressBar.Visibility = "Visible"
            $progressBar.Maximum = $selected.Count
            $progressBar.Value = 0
        
            $count = 0
            foreach ($app in $selected) {
                $count++
                Set-Status "Instalando: $($app.Key) ($count/$($selected.Count))"
                $progressBar.Value = $count
            
                try {
                    $process = Start-Process -FilePath "winget" -ArgumentList "install -e --id $($app.Key) --accept-package-agreements --accept-source-agreements --silent" -Wait -PassThru -NoNewWindow
                }
                catch {}
            }
        
            $progressBar.Visibility = "Collapsed"
            Set-Status "Instalacion completada - $count aplicaciones"
            [System.Windows.MessageBox]::Show("Se instalaron $count aplicaciones.", "Completado", "OK", "Information")
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
            [System.Windows.MessageBox]::Show("Funcionalidad de tweaks proximamente.", "Info", "OK", "Information")
        })
    
    $btnGitHub.Add_Click({
            Start-Process "https://github.com/johnblack593/Script"
        })
    
    $btnExit.Add_Click({
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
