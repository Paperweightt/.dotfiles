## Dotfiles - Windows 11

## Installation
>```
>  winget install --id Git.Git -e --source winget
>  winget install --id GitHub.cli
>  winget install Neovim.Neovim
>  winget install GlazeWM
>  winget install "Flow Launcher"
>  scoop bucket install extras
>  scoop install neovide
>```

## Setup-1 Clone Repo and Initialize
>```
> cd $home
> git clone repo blah blah
> .\.dotfiles\init.ps1
>```

## Setup-2 Manual Setup
>```
> flowlauncher
>```

## Keybinds
- GlazeWm
    - alt-hjkl | move focus
    - alt-HJKL | move focused window
    - alt-uiop | resize window
    - alt-f | set focused window to float
    - alt-t | set focused window to tiling
    - alt-m | maximum focused window
    - alt-n | minimize focused window
    - alt-q | close window
    - alt-a | switch tiling direction
- Powertoys
    - Ctrl-C | Screen Color Picker
- AutoHotkey
    - general
        - ctrl-e | toggle title bar for neovide and powershell (buggy)
    - minecraft
        - ctrl-f | reload minecraft

## Alternatives
- Neovim - code editor
    - Visual Studio Code
    - Zed
    - Emacs
    - Helix
- GlazeWm - windows tiling manager
    - Komorebi (configured)
- Yasb (top bar)
    - zebar
- Flow Launcher - quick launcher
    - PowerToys Run

## Todo List
- Missing Info 
    - Download
        - powertoys
        - Wezterm
    - Configs
        - wezterm
        - yasb
        - flow launcher
        - obsidian
        - vencord
        - spicetify
- Configure
    - wezterm
    - flow launcher
        - theme
        - better plugins
- Wants
    - dedicated markdown displayer
