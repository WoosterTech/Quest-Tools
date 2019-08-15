; Define INI file location
pathINI = %A_AppData%\Quest Integration\QI Tools.ini

; Section of INI file for 3CX
iniSection = BasicShortcuts

; Initialize iniProps
iniProps := {}

; Properties from INI file with their defaults
iniProps["numLockOn"] := 0
iniProps["hkInterval"] := 1000
iniProps["hkMaxPerInt"] := 210
iniProps["zoomEnable"] := 0
iniProps["setVol"] := 0
iniProps["ringWav"] := "ringtone_og.wav"

iniProps := QIFunctions_readINI(pathINI, iniProps, iniSection)

numLockOn := iniProps["numLockOn"]
hkInterval := iniProps["hkInterval"]
hkMaxPerInt := iniProps["hkMaxPerInt"]
zoomEnable := iniProps["zoomEnable"]
setVol := iniProps["setVol"]
ringWav := iniProps["ringWav"]