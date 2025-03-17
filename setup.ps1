# PowerShell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/MutayyibAli/SetupWindows/refs/heads/main/setup.ps1'))"
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

## Select packages to be installed using each package manager

# Activate Windows & Office [www.gravesoft.dev]
# irm https://get.activated.win | iex

# Graphics [https://www.reddit.com/r/GenP/]

# WinGet Packages
$WinGet = @(
    # Browsers
    "Google.Chrome",
    "Mozilla.Firefox",
    "Microsoft.Edge",
    "Opera.Opera",

    # Windows Tools
    "abbodi1406.vcredist", # Microsoft Visual C++ Bundle
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

    # Utilities
    "Tonec.InternetDownloadManager", # Download Manager --requires Crack
    "Adobe.CreativeCloud", # Adobe Creative Cloud --requires Crack
    "Microsoft.Office", # Microsoft Office --requires Crack
    "Microsoft.OneDrive", # Cloud Storage
    "Microsoft.WindowsTerminal", # Terminal Emulator
    "Microsoft.PowerShell", # PowerShell 7
    "Microsoft.PowerToys", # Windows Utilities
    "Microsoft.WSL", # Windows Subsystem for Linux
    "VideoLAN.VLC", # Media Player
    "LocalSend.LocalSend", # File Transfer Tool
    "Apple.iTunes", # iOS Device Manager
    "Apple.AppleMobileDeviceSupport", # iOS Device Support
    "Apple.Bonjour", # Apple Bonjour Service
    "Logitech.Options", # Logitech Mouse & Keyboard Software
    "RustemMussabekov.Raindrop", # Bookmark Manager
    "Zoom.Zoom", # Video Conferencing Tool
    "TeamViewer.TeamViewer", # Remote Desktop
    "Google.ChromeRemoteDesktopHost", # Remote Desktop
    "RARLab.WinRAR", # Archive Tool
    "7zip.7zip", # Archive Tool
    "qBittorrent.qBittorrent", # Torrent Client
    "Rufus.Rufus", # USB Bootable Tool
    "yt-dlp.yt-dlp", # Youtube Downloader --requires Python & ffmpeg
    "Gyan.FFmpeg", # Video Converter Tool 
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
    
    # Programming Languages
    "Python.Python.3.13", # Python Language
    "Python.Launcher", # Python Launcher
    "MSYS2.MSYS2", # C++ Language
    "Oracle.JavaRuntimeEnvironment", # Java Language

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
    @("extras", "extras/sysinternals"), # Driver Store Explorer
)

# Chocolatey Packages
$Choco = @(
    "geforce-experience", # Nvidia GeForce Experience
    "geforce-game-ready-driver", # Nvidia GeForce Game Ready Driver
    "rockstar-launcher" # Rockstar Games Launcher
)

# Applications to be removed
$Remove = @(
    
)

# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================

# Setup global variables
$width = (Get-Host).UI.RawUI.MaxWindowSize.Width

# Print a line on the console for a new section
function New-Section {
    for ($i = 1; $i -le $width; $i++) {
        Write-Host "=" -NoNewline -ForegroundColor Yellow -BackgroundColor DarkRed
    }
    Write-Host ""
}

# Print a line on the console for a new step
function New-Step {
    for ($i = 1; $i -le $width; $i++) {
        Write-Host "-" -NoNewline -ForegroundColor Cyan -BackgroundColor DarkBlue
    }
    Write-Host ""
}

# Print a line on the console between sub-steps
function New-SubStep {
    for ($i = 1; $i -le $width; $i++) {
        Write-Host "-" -NoNewline -ForegroundColor Cyan -BackgroundColor DarkBlue
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
        New-Step
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
        
        New-Step
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
        New-Step
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
        New-Step
    }
}

# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================

## Configure ExecutionPolicy to Unrestricted for CurrentUser Scope
New-Section
Write-Host "Setting Execution Policy for Current Process..."
Set-ExecutionPolicy Bypass -Scope Process -Force
New-Section

## Enable Windows Features
New-Section
Write-Host "Enabling Windows Features..."
New-Step
Write-Host "Enabling Windows Sandbox..."
Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online
New-SubStep
Write-Host "Enabling Windows Subsystem for Linux..."
Enable-WindowsOptionalFeature -FeatureName "Microsoft-Windows-Subsystem-Linux" -All -Online

## Install Package Managers
New-Section
Write-Host "Installing Package Managers..."
New-Step

# Install WinGet
New-Step
Write-Host "Checking WinGet..."
New-SubStep
# Check if Chocolatey is already installed
if (Get-AppPackage -name "Microsoft.DesktopAppInstaller") {
    Write-Host "WinGet already installed!"
    Write-Host "Installing GUI"
    New-SubStep
    winget install --id "MartiCliment.UniGetUI" --exact --source winget --accept-source-agreements --disable-interactivity --silent --accept-package-agreements --force
    New-SubStep
    Write-Host "Installing Widgets"
    winget install --id "9NB9M5KZ8SLX" --exact --source msstore --accept-source-agreements --disable-interactivity --silent  --accept-package-agreements --force
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
if ( Get-Command -Name "scoop" -CommandType Application -ErrorAction SilentlyContinue | Out-Null ) {
    Write-Host "Scoop already installed! Skipping..."
}
else {
    Write-Host "Installing Scoop..."
    New-SubStep
    iwr -useb get.scoop.sh | iex
}

# Install Chocolatey
New-Step
Write-Host "Checking Scoop..."
New-SubStep
# Check if Chocolatey is already installed
if ( Get-Command -Name "choco" -CommandType Application -ErrorAction SilentlyContinue | Out-Null ) {
    Write-Host "Chocolatey already installed! Skipping..."
}
else {
    Write-Host "Installing Chocolatey..."
    New-SubStep
    winget install --id "Chocolatey.Chocolatey" --exact --source winget --accept-source-agreements --disable-interactivity --silent  --accept-package-agreements --force
    winget install --id "Chocolatey.ChocolateyGUI" --exact --source winget --accept-source-agreements --disable-interactivity --silent --accept-package-agreements --force
    # iwr -useb chocolatey.org/install.ps1 | iex
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
    Install-ScoopApp -Package "$item"
}

# Install Scoop Packages
New-Step
Write-Host "Installing Scoop Packages with Buckets..."
foreach ($item in $Scoop) {
    Install-ScoopApp -Bucket "$item[1]" -Package "$item[0]"
}

# Install Chocolatey Packages
New-Step
choco feature enable -n=allowGlobalConfirmation
choco feature disable checksumFiles
Write-Host "Installing Chocolatey Packages..."
foreach ($item in $Choco) {
    Install-ScoopApp -Package "$item"
}

# Remove unused Packages/Applications
New-Step
Write-Host "Removing Unused Applications..."
foreach ($item in $Remove) {
    Remove-InstalledApp -Package $item
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
$guid = ""
$json.profiles.list | ForEach-Object {
    if ($_.name -eq "PowerShell") {
        $guid = $_.guid
    }
}
$json.defaultProfile = $guid
$json | ConvertTo-Json -Depth 10 | Out-File -Encoding utf8 $settings

# Configure Starship
New-Step
Write-Host "Configuring Starship..."
# For Windows Terminal
$myProfile = $Profile
New-Item -ItemType file -Value "Invoke-Expression (&starship init powershell)" -Path $myProfile -Force
# For Powershell 7
$newProfile = $myProfile.Replace('WindowsPowerShell', 'PowerShell')
New-Item -ItemType file -Value "Invoke-Expression (&starship init powershell)" -Path $newProfile -Force

# Configure WSL
New-Step
Write-Host "Configuring WSL"
if (!(Get-Command "wsl" -CommandType Application -ErrorAction Ignore)) {
    Write-Host "Installing Windows SubSystems for Linux..."
    Start-Process -FilePath "PowerShell" -ArgumentList "wsl", "--install" -Verb RunAs -Wait -WindowStyle Hidden
}
New-SubStep
Write-Host "InstallingUbuntu in WSL"
wsl --install -d Ubuntu
Write-Host "Installation complete!"
Write-Host "Restarting Computer"
Start-Sleep -Seconds 10
Exit 0
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================