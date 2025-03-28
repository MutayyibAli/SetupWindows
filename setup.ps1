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
    "Microsoft.OneDrive", # Cloud Storage
    "Microsoft.WindowsTerminal", # Terminal Emulator
    "Microsoft.PowerShell", # PowerShell 7
    "Microsoft.PowerToys", # Windows Utilities
    "Microsoft.WSL", # Windows Subsystem for Linux
    "Microsoft.NuGet", #.NET Package Manager
    "MartiCliment.UniGetUI", # Windows Package Manager

    # Utilities
    "Adobe.CreativeCloud", # Adobe Creative Cloud --requires Crack
    "Microsoft.Office", # Microsoft Office --requires Crack
    "Tonec.InternetDownloadManager", # Download Manager --requires Crack
    "VideoLAN.VLC", # Media Player
    "LocalSend.LocalSend", # File Transfer Tool
    "Apple.iTunes", # iOS Device Manager
    "Apple.AppleMobileDeviceSupport", # iOS Device Support
    "Logitech.OptionsPlus", # Logitech Mouse & Keyboard Software
    "RustemMussabekov.Raindrop", # Bookmark Manager
    "Zoom.Zoom", # Video Conferencing Tool
    "TeamViewer.TeamViewer", # Remote Desktop
    "Google.ChromeRemoteDesktopHost", # Remote Desktop
    "RARLab.WinRAR", # Archive Tool
    "7zip.7zip", # Archive Tool
    "qBittorrent.qBittorrent", # Torrent Client
    "Rufus.Rufus", # USB Bootable Tool
    "Wakatime.DesktopWakatime", # Time Tracking Tool
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
    "Python.Python.3.11", # Python Language
    "Python.Python.3.12", # Python Language
    "Python.Python.3.13", # Python Language
    "Python.Launcher", # Python Launcher
    "Anaconda.Anaconda3", # Anaconda Distribution
    "MSYS2.MSYS2", # C++ Language

    # Additional Tools for Development
    "Docker.DockerDesktop"

)

# Scoop Packages
$Scoop = @(
    @("main", "scoop-search"), # Scoop Search Plugin
    @("nerd-fonts", "Hack-NF"), # Nerd Fonts --requires Starship
    @("extras", "driverstoreexplorer"), # Driver Store Explorer
    @("extras", "sysinternals") # Driver Store Explorer
)

# Chocolatey Packages
$Choco = @(
    
)

## Apps for gaming PC
$WinGetG = @(
    "Valve.Steam", # Game Client
    "EpicGames.EpicGamesLauncher" # Game Client
)

$ScoopG = @(

)

$ChocoG = @(
    "geforce-experience", # Nvidia GeForce Experience
    "geforce-game-ready-driver", # Nvidia GeForce Game Ready Driver
    "rockstar-launcher" # Rockstar Games Launcher
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
    $listApp = winget list
    if (($listApp -match $Package) -or (Get-AppPackage -Name $Package)) {
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

# Check first time running
New-Section
Write-Host "Checking First Time Running..."
New-Step
$selection = Read-Host "Please type YES if this is the first time running the script else PRESS ENTER"
$setup = $true
$install = $true
if ($selection.ToLower() -eq "") {
    $setup = $false
    $select = Read-Host "Please type YES if you want to install app else PRESS ENTER (Upgrade Only)"
    if ($select.ToLower() -eq "") {
        $install = $false
    }
    else {
        if ($select.ToLower() -ne "yes") {
            Write-Host "Invalid Input! Exiting..." -ForegroundColor Red -BackgroundColor White
            Exit 1
        }
    }
}
else {
    if ($selection.ToLower() -ne "yes") {
        Write-Host "Invalid Input! Exiting..." -ForegroundColor Red -BackgroundColor White
        Exit 1
    }
}

# Check PC
New-Section
Write-Host "Checking PC..."
$MainPC = $false
if ((Get-WmiObject Win32_VideoController).Name -like "*NVIDIA*") {
    $MainPC = $true
    Write-Host "Main PC Detected"
}
else {
    Write-Host "Secondary PC Detected"
}

if ($setup) {
    ## Configure Windows Settings
    New-Section
    Write-Host "Configuring Windows Settings..."
    #Configure ExecutionPolicy to Unrestricted for CurrentUser Scope
    New-Step
    Write-Host "Setting Execution Policy for Current Process..."
    Set-ExecutionPolicy -ExecutionPolicy Unrestricted

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

    # Configure Windows Settings
    New-Step
    Write-Host "Configuring Windows Settings..."
    New-SubStep
    # https://github.com/Raphire/Win11Debloat
    & ([scriptblock]::Create((Invoke-RestMethod "https://debloat.raphi.re/"))) -Silent `
        -RemoveApps -RemoveCommApps -DisableDVR -ClearStart -DisableTelemetry -DisableSuggestions `
        -DisableDesktopSpotlight -DisableLockscreenTips -DisableBing -ShowHiddenFolders -ShowKnownFileExt `
        -HideDupliDrive -ShowSearchIconTb -DisableStartRecommended -HideHome -HideGallery -ExplorerToThisPC
    # Options
    # -Silent                       : Suppresses all interactive prompts, so the script will run without requiring any user input.
    # -RunDefaults	                : Run the script with the default settings.
    # -RemoveApps	                : Remove the bloatware apps.
    # -RemoveCommApps	            : Remove the Mail, Calendar, and People apps.
    # -DisableDVR	                : Disable Xbox game/screen recording feature & stop gaming overlay popups.
    # -ClearStart                  : Remove all pinned apps from start.
    # -DisableTelemetry	            : Disable telemetry, diagnostic data & targeted ads.
    # -DisableSuggestions	        : Disable tips, tricks, suggestions and ads in start, settings, notifications and File Explorer.
    # -DisableDesktopSpotlight	    : Disable the 'Windows Spotlight' desktop background option.
    # -DisableLockscreenTips	    : Disable tips & tricks on the lockscreen.
    # -DisableBing	                : Disable & remove Bing web search in Windows search.
    # -ShowHiddenFolders	        : Show hidden files, folders and drives.
    # -ShowKnownFileExt	            : Show file extensions for known file types.
    # -HideDupliDrive	            : Hide duplicate removable drive entries from the File Explorer navigation pane, so only the entry under 'This PC' remains.
    # -TaskbarAlignLeft	            : Align taskbar icons to the left.
    # -ShowSearchIconTb	            : Show search icon on the taskbar.
    # -DisableStartRecommended      : Disable & hide the recommended section in the start menu. This will also change the start menu layout to More pins.
    # -HideHome	                    : Hide the home section from the File Explorer navigation pane and add a toggle in the File Explorer folder options.
    # -HideGallery	                : Hide the gallery section from the File Explorer navigation pane and add a toggle in the File Explorer folder options.
    # -ExplorerToThisPC	            : Changes the page that File Explorer opens to This PC.

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
    #Write-Host "Enabling Windows Features..."
    #if ($MainPC) {
    #New-SubStep
    #Write-Host "Enabling Windows Sandbox..."
    #Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online -NoRestart
    #}
    #New-SubStep
    Write-Host "Enabling Windows Subsystem for Linux..."
    Enable-WindowsOptionalFeature -FeatureName "Microsoft-Windows-Subsystem-Linux" -All -Online -NoRestart

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
}
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================

if ($install) {
    ## Install/Uninstall selected packages
    New-Section
    Write-Host "Installing Packages..."

    # Install WinGet Packages
    New-Step
    Write-Host "Installing WinGet Packages..."
    foreach ($item in $WinGet) {
        Install-WinGetApp -Package "$item"
    }

    # Refresh envirnment variables
    $Env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

    # Install Scoop Packages
    New-Step
    Write-Host "Installing Scoop Packages with Buckets..."
    foreach ($item in $Scoop) {
        Install-ScoopApp -Bucket $item[0] -Package $item[1]
    }

    # Install Chocolatey Packages
    New-Step
    choco feature enable -n=allowGlobalConfirmation
    choco feature disable checksumFiles
    Write-Host "Installing Chocolatey Packages..."
    foreach ($item in $Choco) {
        Install-ChocoApp -Package "$item"
    }

    # If Main PC then install Gaming Apps
    if ($MainPC) {
        # Install WinGet Packages
        New-Step
        Write-Host "Installing WinGet Packages..."
        foreach ($item in $WinGetG) {
            Install-WinGetApp -Package "$item"
        }

        # Install Scoop Packages
        New-Step
        Write-Host "Installing Scoop Packages with Buckets..."
        foreach ($item in $ScoopG) {
            Install-ScoopApp -Bucket $item[0] -Package $item[1]
        }

        # Install Chocolatey Packages
        New-Step
        choco feature enable -n=allowGlobalConfirmation
        choco feature disable checksumFiles
        Write-Host "Installing Chocolatey Packages..."
        foreach ($item in $ChocoG) {
            Install-ChocoApp -Package "$item"
        }
    }
}

if ($setup) {
    # Remove unused Packages/Applications
    New-Step
    Write-Host "Removing Unused Applications..."
    foreach ($item in $RemoveID) {
        Remove-InstalledApp -Package $item
    }

    # Remove unused Packages/Applications by Name
    New-Step
    Write-Host "Removing Unused Applications..."
    foreach ($name in $RemoveName) {
        Remove-InstalledApp -Name $name
    }
}


# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
if ($setup) {
    ## Configure installed applications
    New-Section

    # Configure Git
    New-Step
    Write-Host "Configuring Git..."
    if ($MainPC) {
        $MyName = "Mutayyib-PC"
    }
    else {
        $MyName = "Mutayyib-HP"
    }
    git config --global user.name $MyName
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
    Invoke-RestMethod https://get.activated.win | Invoke-Expression
}
New-Step

# Upgrade Apps
New-Section
Write-Host "Upgrading WinGet Apps..."
winget upgrade --all --silent --accept-package-agreements --accept-source-agreements --force
New-Step
Write-Host "Upgrading Scoop Apps..."
scoop update *
New-Step
Write-Host "Upgrading Chocolatey Apps..."
choco feature enable -n=allowGlobalConfirmation
choco feature disable checksumFiles
choco upgrade all


if ($setup) {
    Write-Host "Restart Computer"
}
Write-Host "Script Completed"
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
# ======================================================================================================================
