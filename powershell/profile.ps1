## path variables
$mojang    = Join-Path $HOME "AppData\Roaming\Minecraft Bedrock\Users\Shared\games\com.mojang"
$mojang2    = Join-Path $HOME "AppData\Roaming\Minecraft Bedrock\Users\15758859223355425889\games\com.mojang"
$packs     = Join-Path $HOME "OneDrive\Desktop\packs"
$dotf      = Join-Path $HOME ".dotfiles"
$startup   = [Environment]::GetFolderPath("Startup")
$projects  = Join-Path $HOME "Projects"
$downloads = Join-Path $HOME "Downloads"
$notes     = Join-Path $HOME "Notes"
$pictures  = Join-Path $HOME "OneDrive\Pictures"
$desktop   = Join-Path $HOME "OneDrive\Desktop"

## for neovim and other tools
$env:MOJANG    = $mojang
$env:MOJANG2   = $mojang2
$env:PACKS     = $packs
$env:DOTF      = $dotf
$env:STARTUP   = $startup
$env:PROJECTS  = $projects
$env:DOWNLOADS = $downloads
$env:NOTES     = $notes
$env:PICTURES  = $pictures
$env:DESKTOP   = $desktop
$env:HOME      = $HOME

function neo
{
    & "$HOME\.dotfiles\neo\neo.ps1"
}

function admin
{
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
    {
        Start-Process -FilePath "pwsh" -ArgumentList "-NoExit" `
            -Verb RunAs
        exit
    }
}

function killnvim
{
    Stop-Process -Name nvim -Force
}

oh-my-posh init pwsh --config "C:\Users\henry\.dotfiles\powershell\oh-my-posh.omp.json"| Invoke-Expression
