#SingleInstance, force 								; Forces only one instance, allows to re-run script without reloading
Menu, Tray, Icon, images\WoosterGraphic.ico		; Icon for this script
Menu, Tray, Tip, WTS: Basic Shortcuts	 		; Change tooltip on icon in tray

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Initialization ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Define INI file location
pathINI = %A_AppData%\WoosterTech\WoosterTech.ini

; Section of INI file for 3CX
iniSection = BasicShortcuts

; Initialize iniProps
iniProps := {}

; Properties from INI file with their defaults
iniProps["numLockOn"] := 0
iniProps["hkInterval"] := 1000
iniProps["hkMaxPerInt"] := 210

iniProps := WTSFunctions_readINI(pathINI, iniProps, iniSection)

numLockOn := iniProps["numLockOn"]
hkInterval := iniProps["hkInterval"]
hkMaxPerInt := iniProps["hkMaxPerInt"]

#HotkeyInterval %hkInterval%						; Defines interval for next line
#MaxHotkeysPerInterval %hkMaxPerInt%				; Sets maximum number of presses of hotkey per interval

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Main Code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
if numLockOn {
	SetNumLockState, AlwaysOn
}