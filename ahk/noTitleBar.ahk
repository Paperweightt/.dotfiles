#SingleInstance Force
Programs := [
    "ahk_exe Neovide.exe",
    "ahk_class ConsoleWindowClass"
]


SetTimer(UpdateTitleBar, 500)

UpdateTitleBar() {
    Loop Programs.length {
        if WinExist(Programs[A_Index]) {
            Try {
                WinSetStyle(-0xC00000, Programs[A_Index])
            }
        }
    }
}


;- Remove Caption (Title Bar)
^e::{
    WinSetStyle(-0xC00000, "A")
}

;+ Restore Caption (Title Bar)
^+e::{
    WinSetStyle("+0xC00000", "A")
}
