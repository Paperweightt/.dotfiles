## path variables
$mojang = Join-Path $env:USERPROFILE "AppData\Local\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang"
$packs = Join-Path $env:USERPROFILE "\OneDrive\Desktop\packs"
$code = "C:\Code"
$dotf = Join-Path $HOME "\.dotfiles"
$startup = [Environment]::GetFolderPath("Startup")

function Admin
{
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
    {
        Start-Process -FilePath "pwsh" -ArgumentList "-NoProfile", "-NoExit" `
            -Verb RunAs
        exit
    }
}
