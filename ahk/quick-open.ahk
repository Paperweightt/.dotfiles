#SingleInstance Force

F19Down := false

*~F19::
{
    F19Down := true
    return
}

*~F19 up::
{
    F19Down := false
    return
}

+D::
{
    if !F19Down 
        return 

    hwnd := WinExist("ahk_exe discord.exe")

    if hwnd {
        WinActivate(hwnd)
    } else {
        Run("C:\Users\henry\AppData\Local\Discord\Update.exe")
    }
}



; F19::Send "{F19}"  ; Restore F19 default behavior
;
; F19 & D::
; {
;     hwnd := WinExist("ahk_exe discord.exe")
;
;     if hwnd {
;         WinActivate(hwnd)
;     } else {
;         Run("C:\Users\henry\AppData\Local\Discord\Update.exe")
;     }
; }

; +!^D::
; {
;     hwnd := WinExist("ahk_exe discord.exe")
;
;     if hwnd {
;         WinActivate(hwnd)
;     } else {
;         Run("C:\Users\henry\AppData\Local\Discord\Update.exe")
;     }
; }
;
; +!^S::
; {
;     hwnd := WinExist("ahk_exe spotify.exe")
;
;     if hwnd {
;         WinActivate(hwnd)
;     } else {
;         Run("C:\Users\henry\AppData\Roaming\Spotify\Spotify.exe")
;     }
; }
;
; +!^C:: 
; {
;     hwnd := WinExist("ahk_exe neovide.exe")
;
;     if hwnd {
;         WinActivate(hwnd)
;     } else {
;         Run("C:\Users\henry\.dotfiles\neo\neo.exe")
;     }
; }
;
; +!^Z::
; {
;     hwnd := WinExist("ahk_exe zen.exe")
;
;     if hwnd {
;         WinActivate(hwnd)
;     } else {
;         Run("C:\Program Files\Zen Browser\zen.exe")
;     }
; }
