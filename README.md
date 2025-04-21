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
```
- GlazeWm
    - Alt+HJKL       | Move focus
    - Alt+Shift+HJKL | Move focused window
    - Alt+123        | Move focus to screen 1 2 3
    - Alt+Shift+123  | Move window to screen 1 2 3
    - Alt+F          | Toggle window to float
    - Alt+T          | Toggle window to tiling
    - Alt+M          | Toggle window to maximize
    - Alt+N          | Toggle window to minimize
    - Alt+A          | Toggle tiling direction
    - Alt+UIOP       | Resize window
    - Alt+Q          | Close window
    - Alt+R          | Reload glazeWm config
- Powertoys
    - Ctrl+Shift+C   | Screen Color Picker
- AutoHotkey
    - general
        - Ctrl+E     | Toggle title bar for neovide and powershell (buggy)
    - minecraft
        - Ctrl+F     | Reload minecraft
```

## Alternatives
```
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
```

## My Todo List
```
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
```
