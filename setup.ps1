# iwr -useb https://raw.githubusercontent.com/MutayyibAli/SetupWindows/refs/heads/main/setup.ps1 | iex
<#
.SYNOPSIS
    Script to setup a new installation of windows.
.DESCRIPTION
    Script uses Winget, Scoop, and Chocolatey to install applications.
.NOTES
    Author: Mutayyib Ali
    Date: March 16th, 2025

    Last Updated: March 16th, 2025
#>

# Activate Windows & Office [www.gravesoft.dev]
# irm https://get.activated.win | iex

# Graphics [https://www.reddit.com/r/GenP/]

## Select packages to be installed using each package manager

# WinGet Packages
$WinGet = @(
    # Browsers
    "Google.Chrome",
    "Mozilla.Firefox",
    "Opera.Opera",

    # Windows Tools
    "Microsoft.VCLibs.Desktop.14",
    "Microsoft.VCRedist.2005.x86",
    "Microsoft.VCRedist.2005.x64",
    "Microsoft.VCRedist.2008.x86",
    "Microsoft.VCRedist.2008.x64",
    "Microsoft.VCRedist.2010.x86",
    "Microsoft.VCRedist.2010.x64",
    "Microsoft.VCRedist.2012.x86",
    "Microsoft.VCRedist.2012.x64",
    "Microsoft.VCRedist.2013.x86",
    "Microsoft.VCRedist.2013.x64",
    "Microsoft.VCRedist.2015+.x86",
    "Microsoft.VCRedist.2015+.x64",
    "Microsoft.DotNet.Runtime.5",
    "Microsoft.DotNet.Runtime.6",
    "Microsoft.DotNet.Runtime.7",
    "Microsoft.DotNet.Runtime.8",
    "Microsoft.DotNet.Runtime.9",
    "Microsoft.DotNet.DesktopRuntime.5",
    "Microsoft.DotNet.DesktopRuntime.6",
    "Microsoft.DotNet.DesktopRuntime.7",
    "Microsoft.DotNet.DesktopRuntime.8",
    "Microsoft.DotNet.DesktopRuntime.9",
    "Microsoft.UI.Xaml.2.8",

    # Microsoft Apps
    "Microsoft.AppInstaller", # App Installer
    "Microsoft.Edge", # Web Browser
    "Microsoft.Teams", # Video Conferencing Tool
    "Microsoft.OneDrive", # Cloud Storage
    "Microsoft.WindowsTerminal", # Terminal Emulator
    "Microsoft.PowerShell", # PowerShell 7
    "Microsoft.PowerToys", # Windows Utilities
    "Microsoft.WSL", # Windows Subsystem for Linux

    # Utilities
    "Adobe.CreativeCloud", # Adobe Creative Cloud --requires Crack
    "Microsoft.Office", # Microsoft Office --requires Crack
    "Tonec.InternetDownloadManager", # Download Manager --requires Crack
    "VideoLAN.VLC", # Media Player
    "LocalSend.LocalSend", # File Transfer Tool
    "Apple.iTunes", # iOS Device Manager
    "Apple.AppleMobileDeviceSupport", # iOS Device Support
    "Logitech.Options", # Logitech Mouse & Keyboard Software
    "RustemMussabekov.Raindrop", # Bookmark Manager
    "Zoom.Zoom", # Video Conferencing Tool
    "TeamViewer.TeamViewer", # Remote Desktop
    "Google.ChromeRemoteDesktopHost", # Remote Desktop
    "RARLab.WinRAR", # Archive Tool
    "7zip.7zip", # Archive Tool
    "qBittorrent.qBittorrent", # Torrent Client
    "Rufus.Rufus", # USB Bootable Tool
    "yt-dlp.yt-dlp", # Youtube Downloader
    "OBSProject.OBSStudio", # Screen Recorder
    "dotPDNLLC.paintdotnet", # Image Editor
    "HandBrake.HandBrake", # Video Transcoder
    "CPUID.HWMonitor", # Hardware Monitor
    "CrystalDewWorld.CrystalDiskMark", # Disk Benchmark Tool
    "Eassos.DiskGenius", # Disk Management Tool
    "PuTTY.PuTTY", # SSH and Telnet Client
    "WinSCP.WinSCP", # SFTP and FTP Client

    # Development Tools
    "Microsoft.VisualStudioCode", # Code Editor
    "Notepad++.Notepad++", # Text Editor
    "Git.Git", # Version Control System
    "GitHub.GitHubDesktop", # Github Desktop Client
    "Starship.Starship", # Cross-Shell Prompt Tool --requires Nerd Fonts -- https://github.com/starship/starship
    "chrisant996.Clink", # Command Prompt Enhancer

    # Programming Languages
    "Python.Python.3.13", # Python Language
    "Python.Launcher", # Python Launcher
    "MSYS2.MSYS2", # C++ Language

    # Additional Tools for Development
    "Docker.DockerDesktop"

    # Gaming Tools
    "Valve.Steam", # Game Client
    "EpicGames.EpicGamesLauncher" # Game Client
)

# Scoop Packages
$Scoop = @(
    @("main", "main/scoop-search"), # Scoop Search Plugin
    @("nerd-fonts", "nerd-fonts/Hack-NF"), # Nerd Fonts --requires Starship
    @("extras", "extras/driverstoreexplorer"), # Driver Store Explorer
    @("extras", "extras/sysinternals") # Driver Store Explorer
)

# Chocolatey Packages
$Choco = @(
    "geforce-experience", # Nvidia GeForce Experience
    "geforce-game-ready-driver", # Nvidia GeForce Game Ready Driver
    "rockstar-launcher" # Rockstar Games Launcher
)

# Pip Packages
$Pip = @(
    # General Python
    "coverage", # Code Coverage Tool
    "pylint", # Code Linter

    # Data Science
    "numpy", # Numerical Python
    "pandas", # Data Analysis Library

    # Data Visualization
    "matplotlib", # Data Visualization Library
    "seaborn", # Data Visualization Library
    "plotly", # Data Visualization Library

    # Machine Learning
    "scikit-learn", # Machine Learning Library
    "scipy", # Scientific Computing Library

    # Web Development
    "flask", # Web App Library
    "django", # Web App Library
    "requests", # HTTP Library
    "beautifulsoup4" # Web Scraping Library
)

# Applications to be removed
$RemoveID = @(
    
)

$RemoveName = @(
    
)

# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================

# Print a line on the console for a new section
function New-Section {
    $width = (Get-Host).UI.RawUI.MaxWindowSize.Width
    for ($i = 1; $i -le $width; $i++) {
        Write-Host "=" -NoNewline -ForegroundColor Yellow -BackgroundColor DarkGreen
    }
    Write-Host ""
}

# Print a line on the console for a new step
function New-Step {
    $width = (Get-Host).UI.RawUI.MaxWindowSize.Width
    for ($i = 1; $i -le $width; $i++) {
        Write-Host "-" -NoNewline -ForegroundColor Cyan -BackgroundColor DarkBlue
    }
    Write-Host ""
}

# Print a line on the console between sub-steps
function New-SubStep {
    $width = (Get-Host).UI.RawUI.MaxWindowSize.Width
    for ($i = 1; $i -le $width; $i++) {
        Write-Host "-" -NoNewline
    }
    Write-Host ""
}
# Install an app using WinGet Package Manager
function Install-WinGetApp {
    param ( [string]$Package )

    New-Step
    Write-Host "Preparing to install " -ForegroundColor Black -BackgroundColor White -NoNewline
    Write-Host "$Package" -ForegroundColor Blue -BackgroundColor White -NoNewline
    Write-Host " using WinGet" -ForegroundColor Black -BackgroundColor White
    New-SubStep

    # Check if the package is already installed
    if (Get-AppPackage -Name $Package) {
        Write-Host "$Package already installed! Skipping..."
        New-Step
    }
    else {
        Write-Host "Installing $Package"
        New-SubStep
        winget install --id "$Package" --silent --exact --accept-source-agreements --accept-package-agreements
        # Options for winget install command
        # --silent                      : To suppress the installation dialog
        # --exact                       : To install the exact package specified
        # --accept-package-agreements   : To accept the package agreements without prompting
        # --accept-source-agreements    : To accept the source agreements without prompting
    }
}

# Install an app with Scoop Package Manager with Bucket
function Install-ScoopApp {
    param ( [string]$Bucket, [string]$Package )

    New-Step
    Write-Host "Preparing to install " -ForegroundColor Black -BackgroundColor White -NoNewline
    Write-Host "$Package" -ForegroundColor Blue -BackgroundColor White -NoNewline
    Write-Host " using Scoop" -ForegroundColor Black -BackgroundColor White
    New-SubStep
    if ((scoop info $Package).Installed ) {
        Write-Host -Message "$Package already installed! Skipping..."
        New-Step
    }
    else {
        Write-Host "Adding $Bucket"
        New-SubStep
        scoop bucket add $Bucket
        New-SubStep
        Write-Host "Installing $Package"
        New-SubStep
        scoop install $Package
        # Options for scoop install command
        
    }
}

# Install an app with Chocolatey Package Manager
function Install-ChocoApp {
    param ( [string]$Package )

    New-Step
    Write-Host "Preparing to install " -ForegroundColor Black -BackgroundColor White -NoNewline
    Write-Host "$Package" -ForegroundColor Blue -BackgroundColor White -NoNewline
    Write-Host " using Chocolatey" -ForegroundColor Black -BackgroundColor White
    New-SubStep

    $listApp = choco list
    if ($listApp -match $Package) {
        Write-Host "Package $Package already installed! Skipping..."
        New-Step
    }
    else {
        Write-Host "Installing $Package"
        New-SubStep
        choco install $package --yes --ignore-checksums
        # Options for choco install command
        # --yes                         : To automatically answer yes to all prompts
        # --ignore-checksums            : To ignore checksums when downloading packages
    }
}

function Install-PipPackage {
    param ( [string]$Package )

    New-Step
    Write-Host "Preparing to install " -ForegroundColor Black -BackgroundColor White -NoNewline
    Write-Host "$Package" -ForegroundColor Blue -BackgroundColor White -NoNewline
    Write-Host " using Pip" -ForegroundColor Black -BackgroundColor White
    New-SubStep

    $listApp = pip list
    if ($listApp -match "$Package ") {
        Write-Host "Package $Package already installed! Skipping..."
        New-Step
    }
    else {
        Write-Host "Installing $Package"
        New-SubStep
        pip install $package
        # Options for pip install command
    }
}

function Remove-InstalledApp {
    param ( [string]$Package )

    New-Step
    Write-Host "Preparing to uninstall " -ForegroundColor Black -BackgroundColor White -NoNewline
    Write-Host "$Package" -ForegroundColor Red -BackgroundColor White -NoNewline
    Write-Host " using WinGet" -ForegroundColor Black -BackgroundColor White
    New-SubStep

    # Check if the package is already installed
    if (!(Get-AppPackage -Name $Package)) {
        Write-Host "$Package not installed! Skipping..."
        New-Step
    }
    else {
        Write-Host "Uninstalling $Package"
        New-SubStep
        winget uninstall --id "$Package" --silent --exact --accept-source-agreements --accept-package-agreements --disable-interactivity
        # Options for winget install command
        # --silent                      : To suppress the installation dialog
        # --exact                       : To install the exact package specified
        # --accept-package-agreements   : To accept the package agreements without prompting
        # --accept-source-agreements    : To accept the source agreements without prompting
        # --disable-interactivity       : To disable interactivity during uninstallation
    }
}

function Remove-InstalledAppByName {
    param ( [string]$Name )

    New-Step
    Write-Host "Preparing to uninstall " -ForegroundColor Black -BackgroundColor White -NoNewline
    Write-Host "$Name" -ForegroundColor Red -BackgroundColor White -NoNewline
    Write-Host " using WinGet" -ForegroundColor Black -BackgroundColor White
    New-SubStep

    # Check if the package is already installed
    if (!(Get-AppPackage -Name $Name)) {
        Write-Host "$Name not installed! Skipping..."
        New-Step
    }
    else {
        Write-Host "Uninstalling $Name"
        New-SubStep
        winget uninstall --name "$Name" --silent --accept-source-agreements --accept-package-agreements --disable-interactivity
        # Options for winget install command
        # --silent                      : To suppress the installation dialog
        # --exact                       : To install the exact package specified
        # --accept-package-agreements   : To accept the package agreements without prompting
        # --accept-source-agreements    : To accept the source agreements without prompting
        # --disable-interactivity       : To disable interactivity during uninstallation
    }
}

function Test-Command {
    param ( [string]$Command )

    if ([bool](Get-Command -Name $Command -CommandType Application -ErrorAction SilentlyContinue) ) {
        return $true
    }
    else {
        return $false
    }
}

# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================

# Request administrator rights
New-Section
Write-Host "Checking Administrator Rights..."
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent() `
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Running as Standard User"
    Write-Host "Please run the script as Administrator" -ForegroundColor Red -BackgroundColor White
    Exit 1
}
else {
    Write-Host "Running as Administrator"
}

## Configure Windows Settings
New-Section
Write-Host "Configuring Windows Settings..."
#Configure ExecutionPolicy to Unrestricted for CurrentUser Scope
New-Step
Write-Host "Setting Execution Policy for Current Process..."
Set-ExecutionPolicy Bypass -Scope Process -Force

# Configure Power Plan
New-Step
Write-Host "Configuring Power Plan..."
New-SubStep
Write-Host "Setting Power Plan to High Performance..."
powercfg.exe -SETACTIVE 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
New-SubStep
Write-Host "Setting Sleep Timeout to 30 minutes..."
Write-Host "Setting Standby Timeout to 0 minutes..."
Write-Host "Setting Hibernate Timeout to 0 minutes..."
powercfg -change -monitor-timeout-ac 30
powercfg -change -standby-timeout-ac 0
powercfg -change -hibernate-timeout-ac 0

# Configure Folder Options
New-Step
Write-Host "Configuring Folder Options..."
New-SubStep
$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Write-Host "Disable show hidden files"
Set-ItemProperty $key Hidden 1
New-SubStep
Write-Host "Showing extensions"
Set-ItemProperty $key HideFileExt 0

# Enable Windows Features
New-Step
Write-Host "Enabling Windows Features..."
New-SubStep
Write-Host "Enabling Windows Sandbox..."
Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online
New-SubStep
Write-Host "Enabling Windows Subsystem for Linux..."
Enable-WindowsOptionalFeature -FeatureName "Microsoft-Windows-Subsystem-Linux" -All -Online

## Install Package Managers
New-Section
Write-Host "Installing Package Managers..."

# Install WinGet
New-Step
Write-Host "Checking WinGet..."
New-SubStep
if (Get-AppPackage -name "Microsoft.DesktopAppInstaller") {
    Write-Host "WinGet already installed!"
    Write-Host "Installing GUI"
    New-SubStep
    Install-WinGetApp -Package "MartiCliment.UniGetUI"
    New-SubStep
    Write-Host "Installing Widgets"
    Install-WinGetApp -Package "9NB9M5KZ8SLX"
}
else {
    Write-Host "You should have Windows 11 to use WinGet"
    Exit 1
}

# Install Scoop
New-Step
Write-Host "Checking Scoop..."
New-SubStep
# Check if Scoop is already installed
if ( Test-Command -Command "scoop" ) {
    Write-Host "Scoop already installed! Skipping..."
}
else {
    Write-Host "Installing Scoop..."
    New-SubStep
    Invoke-Expression "& {$(Invoke-RestMethod get.scoop.sh)} -RunAsAdmin"
}

# Install Chocolatey
New-Step
Write-Host "Checking Chocolatey..."
New-SubStep
# Check if Chocolatey is already installed
if ( Test-Command -Command "choco" ) {
    Write-Host "Chocolatey already installed! Skipping..."
}
else {
    Write-Host "Installing Chocolatey..."
    New-SubStep
    winget install --id "Chocolatey.Chocolatey" --exact --source winget --accept-source-agreements --disable-interactivity --silent  --accept-package-agreements --force
    winget install --id "Chocolatey.ChocolateyGUI" --exact --source winget --accept-source-agreements --disable-interactivity --silent --accept-package-agreements --force
    # iwr -useb chocolatey.org/install.ps1 | iex
    # Invoke-WebRequest -useb chocolatey.org/install.ps1 | Invoke-Expression
}

# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================

## Install/Uninstall selected packages
New-Section
Write-Host "Installing Packages..."

# Install WinGet Packages
New-Step
Write-Host "Installing WinGet Packages..."
foreach ($item in $WinGet) {
    Install-WinGetApp -Package "$item"
}

# Install Scoop Packages
New-Step
Write-Host "Installing Scoop Packages with Buckets..."
foreach ($item in $Scoop) {
    Install-ScoopApp -Bucket $item[1] -Package $item[0]
}

# Install Chocolatey Packages
New-Step
choco feature enable -n=allowGlobalConfirmation
choco feature disable checksumFiles
Write-Host "Installing Chocolatey Packages..."
foreach ($item in $Choco) {
    Install-ChocoApp -Package "$item"
}

# Install Pip Packages
New-Step
Write-Host "Installing Pip Packages..."

Start-Sleep -Seconds 5
refreshenv
Start-Sleep -Seconds 5

foreach ($item in $Pip) {
    Install-PipPackage -Package "$item"
}

# Remove unused Packages/Applications
New-Step
Write-Host "Removing Unused Applications..."
foreach ($item in $Remove) {
    Remove-InstalledApp -Package $item
}

# Remove unused Packages/Applications by Name
New-Step
Write-Host "Removing Unused Applications..."
foreach ($name in $RemoveName) {
    Remove-InstalledApp -Name $name
}

# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================

## Configure installed applications
New-Section
Start-Sleep -Seconds 5
refreshenv
Start-Sleep -Seconds 5

# Configure Git
New-Step
Write-Host "Configuring Git..."
git config --global user.name "Mutayyib Ali"
git config --global user.email "mutayyibali@gmail.com"

# Configure PowerShell
New-Step
Write-Host "Configuring PowerShell..."
$settings = "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_*\LocalState\settings.json"
$json = Get-Content -Raw $settings | ConvertFrom-Json
Write-Host $json
$json.profiles.list | ForEach-Object {
    if ($_.name -eq "PowerShell") {
        $json.defaultProfile = $_.guid
    }
}
$json | ConvertTo-Json -Depth 10 | Out-File -Encoding utf8 $settings

## Configure Starship
New-Step
Write-Host "Configuring Starship..."

# For Windows Terminal
$myProfile = $Profile
New-Item -ItemType file -Value "Invoke-Expression (&starship init powershell)" -Path $myProfile -Force
# For Powershell 7
$newProfile = $myProfile.Replace('WindowsPowerShell', 'PowerShell')
New-Item -ItemType file -Value "Invoke-Expression (&starship init powershell)" -Path $newProfile -Force
# For Bash
New-Item -ItemType file -Value 'eval "$(starship init bash)"' -Path "$HOME/.bashrc" -Force

#Set Theme
New-SubStep
Write-Host "Setting Theme"
starship preset pastel-powerline -o "$HOME/.config/starship.toml"

# Configure WSL
New-Step
Write-Host "Configuring WSL"
if (!(Test-Command -Command "wsl")) {
    Write-Host "Installing Windows SubSystems for Linux..."
    wsl --install
}
New-SubStep
Write-Host "Installing Ubuntu in WSL"
New-SubStep
wsl --install -d Ubuntu
Write-Host "Installation complete!"

# Crack Microsoft Office
New-Step
irm https://get.activated.win | iex

New-Step
Write-Host "Restart Computer"
Start-Sleep -Seconds 10
Exit 0
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================