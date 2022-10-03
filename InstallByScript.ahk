;
; AutoHotKey Version: 1.x
; Author: Karl Wooster <karl@woostertech.com>
;
; Script Function:
;   Install Scripts to local profile when admin permissions not available. Does not show up in Windows `Programs and Features`
;   May be deprecating msi installer just for ease of maintenance of package

#NoEnv
#NoTrayIcon
#SingleInstance, force

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Initialization ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Define INI file location
pathINI = % A_AppData "\Wooster Technical Solutions\WoosterTech.ini"

; Section of INI file for 3CX
iniSection = InstallByScript

; Initialize iniProps
iniProps := {}

; Properties from INI file with their defaults
iniProps["test_write"] := True

iniProps := WTSFunctions_readINI(pathINI, iniProps, iniSection)

numLockOn := iniProps["test_write"]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Main Code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Opens a G2M prompt to start or join a meeting
; ^!g::Run, "gotomeeting://SALaunch?Action=Host"