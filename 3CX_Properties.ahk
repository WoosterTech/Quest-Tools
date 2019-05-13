; Define INI file location
pathINI = %A_AppData%\Quest Integration\QI Tools.ini

; Section of INI file for 3CX
iniSection = 3CX

; Initialize iniProps
iniProps := {}

; Properties from INI file with their defaults
iniProps["3cxSleep"] := 100
iniProps["numEnter"] := "F11"
iniProps["phoneFocus"] := "F12"

iniProps := QIFunctions_readINI(pathINI, iniProps, iniSection)

3cxSleep := iniProps["3cxSleep"]
numEnter := iniProps["numEnter"]
phoneFocus := iniProps["phoneFocus"]