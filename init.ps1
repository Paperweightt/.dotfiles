# Powershell ------------------------------------------------------------------------------------
# Path to the default PowerShell profile
$profilePath = $PROFILE

# Path to your dotfiles version
$dotfilesProfilePath = "$HOME\.dotfiles\Microsoft.PowerShell_profile.ps1"

# Ensure the profile directory exists
$profileDir = Split-Path $profilePath
if (-not (Test-Path $profileDir)) {
    Write-Host "Creating profile directory at $profileDir"
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
}

# Create the profile file if it doesn't exist
if (-not (Test-Path $profilePath)) {
    Write-Host "Creating new PowerShell profile at $profilePath"
    New-Item -ItemType File -Path $profilePath | Out-Null
}

# Check if the sourcing line is already present
$sourceLine = ". `"$dotfilesProfilePath`""
$profileContent = Get-Content $profilePath -Raw

if ($profileContent -notmatch [regex]::Escape($dotfilesProfilePath)) {
    Write-Host "Adding dotfiles profile sourcing to $profilePath"
    Add-Content -Path $profilePath -Value "`n$sourceLine"
} else {
    Write-Host "Dotfiles profile already sourced in $profilePath"
}


# ahk -------------------------------------------------------------------------------------------
$ahkDir = "$HOME\.dotfiles\ahk"  # Replace with your AHK scripts folder path
$startupDir = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"

if (-not (Test-Path $ahkDir)) {
    Write-Host "AHK directory not found: $ahkDir" -ForegroundColor Red
    exit
}

$wsh = New-Object -ComObject WScript.Shell

Get-ChildItem -Path $ahkDir -Filter *.ahk | ForEach-Object {
    $scriptPath = $_.FullName
    $shortcutPath = Join-Path $startupDir ($_.BaseName + ".lnk")

    $shortcut = $wsh.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $scriptPath
    $shortcut.WorkingDirectory = $ahkDir
    $shortcut.Save()

    Write-Host "Created shortcut for '$($_.Name)' in Startup folder."
}

Write-Host "`nAll done ✅"

