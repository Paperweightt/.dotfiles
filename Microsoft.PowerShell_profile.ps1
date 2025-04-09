## path variables
$mojang = Join-Path $env:USERPROFILE "AppData\Local\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang"
$packs = Join-Path $env:USERPROFILE "\OneDrive\Desktop\packs"
$code = "C:\Code"
$dotf = Join-Path $HOME "\.dotfiles"
$startupDir = [Environment]::GetFolderPath("Startup")

## config paths

$env:XDG_CONFIG_HOME = "$HOME\.dotfiles" > $null # neovim 
setx GLAZEWM_CONFIG_PATH "$HOME\.dotfiles\glazeWm.yaml" > $null 2>&1 # glazewm
## not in use
## komorebi
# $env:KOMOREBI_CONFIG_HOME = "$HOME\.dotfiles\komorebi"
# $env:WHKD_CONFIG_HOME = "$HOME\.dotfiles\komorebi"
