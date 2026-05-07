#SingleInstance Force

remove := true
Programs := [
    "ahk_exe Neovide.exe",
    "ahk_class ConsoleWindowClass",
    "ahk_class Emacs"
]

SetTimer(removeTitleBar, 500)

removeTitleBar() {
    global remove
    if remove { 
        Loop Programs.length {
            if WinExist(Programs[A_Index]) {
                Try {
                    WinSetStyle(-0xC00000, Programs[A_Index])
                }
            }
        }
    } 
}

restoreTitleBar() {
    global remove
    remove := false
    ;WinSetStyle("+0xC00000", "A")
    Loop Programs.length {
        if WinExist(Programs[A_Index]) {
            Try {
                WinSetStyle(+0xC00000, Programs[A_Index])
            }
        }
    }
}

;^e::{
;    global remove
;
;    if remove == true {
;        remove := false
;        restoreTitleBar()
;    } else {
;        remove := true
;    }
;}
