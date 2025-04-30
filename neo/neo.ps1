$profilePath = "$home/.dotfiles/powershell/Microsoft.PowerShell_profile.ps1"

if (Test-Path $profilePath)
{
    . $profilePath
} else
{
    Write-Error "profile not found"
}

& "neovide" @args
