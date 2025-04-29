
Invoke-ps2exe `
    -inputFile "C:\Users\henry\.dotfiles\neovide\launcher.ps1" `
    -outputFile "C:\Users\henry\.dotfiles\neovide\launcher.exe"


## Path where you want the shortcut to go
#$shortcutPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\nvide.lnk"
#
## Target program (Neovide executable)
#$targetPath = "C:\Users\henry\.dotfiles\neovide\launcher.ps1"
#
## Create a WScript.Shell COM object
#$WshShell = New-Object -ComObject WScript.Shell
#
## Create the shortcut
#$shortcut = $WshShell.CreateShortcut($shortcutPath)
#
## Set shortcut properties
#$shortcut.TargetPath = $targetPath
#$shortcut.Save()
#
#Write-Host "Shortcut created at $shortcutPath ✅"


