; Define INI file location
pathINI = %A_AppData%\Quest Integration\QI Tools.ini

; Section of INI file for 3CX
iniSection = 3CX

; Initialize iniProps
iniProps := {}

; Properties from INI file with their defaults
iniProps["startTime"] := "08:00"		; Excluded files (these won't run automatically)
iniProps["queueOn"] := "*62"										; Program path
iniProps["queueOff"] := "*63"

iniProps := QIFunctions_readINI(pathINI, iniProps, iniSection)

fName_List := StrSplit(iniProps["fileNames"], ",")										; Separate file names into array (excluded files)

startTime := iniProps["startTime"]
queueOn := iniProps["queueOn"]
queueOff := iniProps["queueOff"]