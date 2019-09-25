; Define INI file location
pathINI = %A_AppData%\Quest Integration\QI Tools.ini

; Section of INI file for RunAll
iniSection = RunAll

; Initialize iniProps
iniProps := {}

; Properties from INI file with their defaults
iniProps["fileNames"] := "uninstall.exe,SOLIDWORKS Reset.exe,3DConnexion Reset.exe,Run All.exe"		; Excluded files (these won't run automatically)
iniProps["runPath"] := "Quest Integration\QI Tools"										; Program path

iniProps := QIFunctions_readINI(pathINI, iniProps, iniSection)

fName_List := StrSplit(iniProps["fileNames"], ",")										; Separate file names into array (excluded files)

runPath := iniProps["runPath"]