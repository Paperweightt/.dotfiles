$profilePath = "$home/.dotfiles/powershell/Microsoft.PowerShell_profile.ps1"
$version = "0.1.0"

if (Test-Path $profilePath)
{
    . $profilePath
} else
{
    Write-Error "profile not found"
}

if ($args -contains "--version")
{
    Write-Output "neo v$version"
    exit
}

& "neovide" @args
