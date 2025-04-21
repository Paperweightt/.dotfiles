Remove-Item -Path "$home/.config/yasb/config.yaml"

New-Item -ItemType SymbolicLink `
    -Path "$home/.config/yasb/config.yaml" `
    -Value "$home/.dotfiles/yasb/config.yaml"

Remove-Item -Path "$home/.congig/yasb/styles.yaml"

New-Item -ItemType SymbolicLink `
    -Path "$home/.config/yasb/styles.css" `
    -Value "$home/.config/yasb/styles.css"
