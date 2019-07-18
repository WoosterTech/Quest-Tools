; Define INI file location
pathINI = %A_AppData%\Quest Integration\QI Tools.ini

; Section of INI file for QSC
iniSection = QuickStatusChange

; Initialize iniProps
iniProps := {}

; Properties from INI file with their defaults
iniProps["teamsSleep"] := 250
iniProps["onCallPos"] := "80,500"
iniProps["onCallColors"] := "0x0000FF,0x575757,0xC1C1C1,0xFF0000"
iniProps["codeIndex"] := 3
iniProps["changeTeams"] := 1
iniProps["change3CX"] := 1

iniProps := QIFunctions_readINI(pathINI, iniProps, iniSection)

onCallPosXY := StrSplit(iniProps["onCallPos"], ",")							; Separate X and Y components of read value
onCallColorList := StrSplit(iniProps["onCallColors"], ",")					; Separate colors into array of n-size

codeF1 = % "*" iniProps["codeIndex"] "0"									; Available
codeF2 = % "*" iniProps["codeIndex"] "1"									; Away
codeF3 = % "*" iniProps["codeIndex"] "2"									; DND
codeF5 = % "*" iniProps["codeIndex"] "3"									; n/a
codeF6 = % "*" iniProps["codeIndex"] "4"									; Lunch
codeF7 = % "*62"															; Queue log in
codeF8 = % "*63"															; Queue log out

teamsSleep := iniProps["teamsSleep"]
changeTeams := iniProps["changeTeams"]
change3CX := iniProps["change3CX"]