#SingleInstance Force

+!^D::
{
    hwnd := WinExist("ahk_exe discord.exe")

    if hwnd {
        WinActivate(hwnd)
    } else {
        Run("C:\Users\henry\AppData\Local\Discord\Update.exe")
    }
}

+!^S::
{
    hwnd := WinExist("ahk_exe spotify.exe")

    if hwnd {
        WinActivate(hwnd)
    } else {
        Run("C:\Users\henry\AppData\Roaming\Spotify\Spotify.exe")
    }
}

+!^C:: 
{
    hwnd := WinExist("ahk_exe neovide.exe")

    if hwnd {
        WinActivate(hwnd)
    } else {
        Run("C:\Users\henry\.dotfiles\neo\neo.exe")
    }
}

+!^Z::
{
    hwnd := WinExist("ahk_exe zen.exe")

    if hwnd {
        WinActivate(hwnd)
    } else {
        Run("C:\Program Files\Zen Browser\zen.exe")
    }
}
