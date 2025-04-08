## path variables
$MOJANG = Join-Path $env:USERPROFILE "AppData\Local\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang"
$PACKS = Join-Path $env:USERPROFILE "\OneDrive\Desktop\packs"
$CODE = "C:\Code"
$DOTF = Join-Path $HOME "\.dotfiles"

## neovim path
$env:XDG_CONFIG_HOME = "$HOME\.dotfiles"
