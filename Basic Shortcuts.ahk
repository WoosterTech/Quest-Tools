#SingleInstance, force 								; Forces only one instance, allows to re-run script without reloading
Menu, Tray, Icon, images\red_q_on_blue_bkgd.ico		; Icon for this script
Menu, Tray, Tip, QI Tools: Basic Shortcuts	 		; Change tooltip on icon in tray

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Initialization ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

iniProps := QIFunctions_readINI(pathINI, iniProps, iniSection)

numLockOn := iniProps["numLockOn"]
hkInterval := iniProps["hkInterval"]
hkMaxPerInt := iniProps["hkMaxPerInt"]

#HotkeyInterval %hkInterval%						; Defines interval for next line
#MaxHotkeysPerInterval %hkMaxPerInt%				; Sets maximum number of presses of hotkey per interval

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Main Code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
if numLockOn {
	SetNumLockState, AlwaysOn
}