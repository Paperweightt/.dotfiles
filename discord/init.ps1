if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
            [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    $script = $MyInvocation.MyCommand.Definition
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$script`"" -Verb RunAs
    exit
}

$vencord_themes = "C:\Users\henry\AppData\Roaming\Vencord\themes"

if (Test-Path $vencord_themes) {
    Remove-Item -Path $vencord_themes
}

New-Item -ItemType SymbolicLink `
    -Path $vencord_themes `
    -Target "$home/.dotfiles/discord/themes/"
