#SingleInstance, force

; Run, Calc.exe
; WinWait, Calculator
; Sleep, 3000
^Numpad8::
WinGetText, text  ; The window found above will be used.
MsgBox, The text is:`n%text%