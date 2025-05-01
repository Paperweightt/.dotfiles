## path variables
$env:MOJANG = Join-Path $env:USERPROFILE "AppData\Local\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang"
$env:PACKS = Join-Path $env:USERPROFILE "\OneDrive\Desktop\packs"
$env:CODE = "C:\Code"
$env:DOTF = Join-Path $HOME "\.dotfiles"
$env:STARTUP = [Environment]::GetFolderPath("Startup")
$env:PROJECTS = Join-Path $HOME "\Projects"
$env:DOWNLOADS = Join-Path $HOME "\Downloads"

function neo
{
    & "$HOME\.dotfiles\neo\neo.ps1"
}

function Admin
{
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
    {
        Start-Process -FilePath "pwsh" -ArgumentList "-NoProfile", "-NoExit" `
            -Verb RunAs
        exit
    }
}
