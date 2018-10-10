^F1::
WinActivate, ahk_exe HipChat.exe
Send, /dnd on phone{Enter}
Send, !{Tab}
return

^F2::
WinActivate, ahk_exe HipChat.exe
Send, /back{Enter}
Send, !{Tab}
return

^F3::
WinActivate, ahk_exe HipChat.exe
var:=A_Now
EnvAdd, var, 15, mins
FormatTime, var, %var%, h:mm
SendInput, /away back ~%Var%{Enter}
return

^F4::
WinActivate, ahk_exe HipChat.exe
Send, /away pm me{Enter}
;Send, !{Tab}
return