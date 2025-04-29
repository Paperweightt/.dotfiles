## path variables
$env:mojang = Join-Path $env:USERPROFILE "AppData\Local\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang"
$env:packs = Join-Path $env:USERPROFILE "\OneDrive\Desktop\packs"
$env:code = "C:\Code"
$env:dotf = Join-Path $HOME "\.dotfiles"
$env:startup = [Environment]::GetFolderPath("Startup")
$env:projects = Join-Path $HOME "\Project"

function nvide
{
    & "$HOME\.dotfiles\neovide\launcher.ps1"
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
