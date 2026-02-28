# if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
#             [Security.Principal.WindowsBuiltInRole] "Administrator")) {
#     $script = $MyInvocation.MyCommand.Definition
#     Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$script`"" -Verb RunAs
#     exit
# }

$config_path = "$home/Appdata/Roaming/qutebrowser/config"

if (Test-Path $config_path) {
    Remove-Item -Path $config_path
}
#oil:///C/Users/henry/AppData/Roaming/qutebrowser/config/
New-Item -ItemType SymbolicLink `
    -Path $config_path `
    -Target "$home/.dotfiles/qutebrowser/config"

