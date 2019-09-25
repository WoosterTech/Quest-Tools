; Define INI file location
pathINI = %A_AppData%\Quest Integration\QI Tools.ini

; Section of INI file for 3CX
iniSection = SW_Reset

; Initialize iniProps
iniProps := {}

; Properties from INI file with their defaults
iniProps["process_name"] := "sldworks.exe"
iniProps["program_name"] := "SOLIDWORKS"
iniProps["start_path"] := "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\SOLIDWORKS 2019\SOLIDWORKS 2019.lnk"

iniProps := QIFunctions_readINI(pathINI, iniProps, iniSection)

process_name := iniProps["process_name"]
program_name := iniProps["program_name"]
start_path := iniProps["start_path"]