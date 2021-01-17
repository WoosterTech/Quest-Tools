#SingleInstance, force 								; Forces only one instance, allows to re-run script without reloading
Menu, Tray, Icon, images\WoosterGraphic.ico			; Icon for this script
Menu, Tray, Tip, WTS: AppKill	 					; Change tooltip on icon in tray

DetectHiddenWindows, On
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Initialization ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Define INI file location
pathINI = % A_AppData "\Wooster Technical Solutions\WoosterTech.ini"

; Section of INI file for 3CX
iniSection = AppKill

; Initialize iniProps
iniProps := {}

; Properties from INI file with their defaults
iniProps["process_name"] := "Teams.exe"
iniProps["program_name"] := "Teams"
iniProps["wait_time"] := 3
iniProps["enableAppKill"] := true
iniProps["keyAppKill"] := "<^<!Numpad5"

iniProps := WTSFunctions_readINI(pathINI, iniProps, iniSection)

process_name := iniProps["process_name"]
program_name := iniProps["program_name"]
wait_time := iniProps["wait_time"]
enableAppKill := iniProps["enableAppKill"]
keyAppKill := iniProps["keyAppKill"]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Main Code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
if enableAppKill
{
	Hotkey, %keyAppKill%, appkill
	return

	appkill:
	if WinExist("ahk_exe Teams.exe")
	{
		; MsgBox, Found Teams
	; Process, Exist, %process_name%						; Check to make sure that it's running
	; If ErrorLevel {										; Returns 0 if no matching program
		ToolTip, Stopping %program_name%
		Process, Close, %process_name%
		; Process, Close, %process_name%
		WinWaitClose, , , 3
		if ErrorLevel
		{
		; Process, WaitClose, %process_name%, %wait_time%				; Ensure process is killed before continuing
		; If ErrorLevel {
			Tooltip
			MsgBox, 16, AppKill, Unable to close %program_name%, 5
			Exit
		}
		Tooltip, Teams Stopped
		Sleep, 3000
		ToolTip
	; }
	} else {
		MsgBox, 16, AppKill, % "Did not find " program_name
	}
	return
}