## Dotfiles - Windows 11

## Installation

> ```powershell
> winget install --id Git.Git -e --source winget
> winget install --id GitHub.cli
> winget install Neovim.Neovim
> winget install GlazeWM
> winget install "Flow Launcher"
> winget install Node.JS
>
> npm install --save-dev --save-exact prettier
>
> scoop bucket add extras
> scoop install neovide
> scoop install extras/yasb
> ```

## Setup-1 Clone Repo and Initialize

> ```powershell
> cd $HOME
> gh repo clone Paperweightt/dotfiles
> .\.dotfiles\init.ps1
> ```

## Setup-2 Manual Setup

> ```
> Flowlauncher
> Tridactyl
> ```

# Linux - Neovim Only

> ```bash
> cd $XDG_CONFIG_HOME/
>
> rm nvim -f -r
>
> git clone --filter=blob:none --no-checkout https://github.com/Paperweightt/dotfiles
> cd dotfiles
> git sparse-checkout init --cone
> git sparse-checkout set examples/blog
> git checkout
>
> mv nvim ../
> cd ../
> rm ./.dotfiles -f -r
> ```

## Keybinds

```
- GlazeWm
    - Alt+HJKL       | Move focus
    - Alt+Shift+HJKL | Move focused window
    - Alt+1234       | Move focus to screen 1 2 3 4
    - Alt+Shift+1234 | Move window to screen 1 2 3 4
    - Alt+Ctrl+HJKL  | Resize window
    - Alt+F          | Toggle window to float
    - Alt+T          | Toggle window to tiling
    - Alt+M          | Toggle window to maximize
    - Alt+N          | Toggle window to minimize
    - Alt+A          | Toggle tiling direction
    - Alt+Q          | Close window
    - Alt+R          | Reload glazeWm config
- Powertoys
    - Ctrl+Shift+C   | Screen Color Picker
- AutoHotkey
    - minecraft
        - Ctrl+F     | Reload minecraft
```

## Alternatives

```
- Neovim - Code editor
    - Visual Studio Code
    - Zed
    - Emacs
    - Helix
- GlazeWm - Windows tiling manager
    - Komorebi
- Yasb - Top bar
    - Zebar
- Flow Launcher - Quick launcher
    - PowerToys Run
- Tridactyl - Browser vim keybinds
    - Vimium
    - Vimium C
- Zen - Browser
    - Brave
```

## My Todo List

```
- Missing Info
    - Download
        - Powertoys
    - Configs
        - Flow Launcher
        - Obsidian
- Configure
    - Flow launcher
        - Theme
        - Better plugins
- Wants
    - Dedicated markdown displayer
```
