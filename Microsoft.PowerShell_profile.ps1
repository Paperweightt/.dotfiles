## path variables
$mojang = Join-Path $env:USERPROFILE "AppData\Local\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang"
$packs = Join-Path $env:USERPROFILE "\OneDrive\Desktop\packs"
$code = "C:\Code"
$dotf = Join-Path $HOME "\.dotfiles"
# $startupDir = [Environment]::GetFolderPath("Startup")

## config paths

$env:XDG_CONFIG_HOME = "$env:USERPROFILE\.dotfiles" # neovim 
$env:WEZTERM_CONFIG_FILE = "$env:USERPROFILE\.dotfiles\wezterm.lua"

setx GLAZEWM_CONFIG_PATH "$env:USERPROFILE\.dotfiles\glazeWm.yaml" > $null 2>&1 # glazewm
## not in use
## komorebi
# $env:KOMOREBI_CONFIG_HOME = "$HOME\.dotfiles\komorebi"
# $env:WHKD_CONFIG_HOME = "$HOME\.dotfiles\komorebi"


function Admin
{
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
    {
        Start-Process -FilePath "pwsh" -ArgumentList "-NoProfile", "-NoExit" `
            -Verb RunAs
        exit
    }
}

