#SingleInstance, force 								; Forces only one instance, allows to re-run script without reloading
Menu, Tray, Icon, images\red_q_on_blue_bkgd.ico		; Icon for this script
Menu, Tray, Tip, QI Tools: SOLIDWORKS Kill	 		; Change tooltip on icon in tray

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Initialization ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Define INI file location
pathINI = %A_AppData%\Quest Integration\QI Tools.ini

; Section of INI file for 3CX
iniSection = SW_Kill

; Initialize iniProps
iniProps := {}

; Properties from INI file with their defaults
iniProps["process_name"] := "sldworks.exe"
iniProps["program_name"] := "SOLIDWORKS"
; iniProps["start_path"] := "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\SOLIDWORKS 2020\SOLIDWORKS 2020.lnk"

iniProps := QIFunctions_readINI(pathINI, iniProps, iniSection)

process_name := iniProps["process_name"]
program_name := iniProps["program_name"]
; start_path := iniProps["start_path"]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Main Code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Process, Exist, %process_name%						; Check to make sure that it's running
If ErrorLevel {										; Returns 0 if no matching program
	ToolTip, Stopping %program_name%
	Process, Close, %process_name%

	Process, WaitClose, %process_name%, 5				; Ensure process is killed before continuing
	If ErrorLevel {
		MsgBox, 8208, Error, Unable to close %program_name%, 5
		Exit
	}

	ToolTip, %program_name% killed
	; ToolTip
	;
	; ToolTip, Starting %program_name%
	; Run, %start_path%
	;
	; Process, Wait, %process_name%
	; If not ErrorLevel {
	; 	MsgBox, 8208, Error, "%program_name% Timed Out", 3
	; 	Exit
	; }

	Sleep, 3000											; Keep tooltip visible for 3 seconds after process is "up"
	ToolTip
}
