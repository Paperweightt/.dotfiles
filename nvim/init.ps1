setx XDG_CONFIG_HOME "%USERPROFILE%\.dotfiles"
Write-Output "Set XDG_CONFIG_HOME to .dotfiles in User Environement Variables"


$source = "C:\Program Files\WindowsApps\MICROSOFT.MINECRAFTUWP_1.26.1301.0_x64__8wekyb3d8bbwe\data"
$packs = Join-Path $HOME "OneDrive\Desktop\packs"
$samples = Join-Path $packs ".resources\samples"

if (Test-Path $source) {
    echo "$source\resource_packs\vanilla\"
    echo "$samples\rp"

    New-Item -ItemType SymbolicLink `
        -Target "$source\resource_packs\vanilla\" `
        -Path "$samples\rp"

    New-Item -ItemType SymbolicLink `
        -Target "$source\behavior_packs\vanilla\" `
        -Path "$samples\bp"
}

