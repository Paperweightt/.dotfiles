$profilePath = "$home/.dotfiles/powershell/profile.ps1"
$version = "0.1.0"

if (Test-Path $profilePath)
{
    . $profilePath
} else
{
    Write-Error "profile not found"
}

# this does not work lol
if ($args -contains "--version")
{
    Write-Output "neo v$version"
    exit
}

& "neovide" @args
