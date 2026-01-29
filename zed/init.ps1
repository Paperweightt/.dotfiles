if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
            [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    $script = $MyInvocation.MyCommand.Definition
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$script`"" -Verb RunAs
    exit
}

$settings_path = "$home/Appdata/Roaming/Zed/settings.json"

if (Test-Path $settings_path) {
    Remove-Item -Path $settings_path
}

New-Item -ItemType SymbolicLink `
    -Path $settings_path `
    -Target "$home/.dotfiles/zed/settings.json"

$keymap_path = "$home/Appdata/Roaming/Zed/keymap.json"

if (Test-Path $keymap_path) {
    Remove-Item -Path $keymap_path
}

New-Item -ItemType SymbolicLink `
    -Path $keymap_path `
    -Target "$home/.dotfiles/zed/keymap.json"

