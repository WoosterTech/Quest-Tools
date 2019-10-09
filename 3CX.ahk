#SingleInstance, force
Menu, Tray, Icon,  images\red_q_on_blue_bkgd.ico
Menu, Tray, Tip, QI Tools: 3CX

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Initialization ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Define INI file location
pathINI = %A_AppData%\Quest Integration\QI Tools.ini

; Section of INI file for 3CX
iniSection = 3CX

; Initialize iniProps
iniProps := {}

; Properties from INI file with their defaults
iniProps["3cxSleep"] := 100
iniProps["numEnter"] := "$numlock"
; iniProps["phoneFocus"] := "F12"
iniProps["pnRegEx"] := "^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$"
iniProps["RegExOut"] := "($2) $3-$4"
iniProps["debug0"] := 0

iniProps := QIFunctions_readINI(pathINI, iniProps, iniSection)

3cxSleep := iniProps["3cxSleep"]
numEnter := iniProps["numEnter"]
; phoneFocus := iniProps["phoneFocus"]
pnRegEx := iniProps["pnRegEx"]
RegExOut := iniProps["RegExOut"]
debug0 := iniProps["debug0"]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Main Code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Hotkey, %numEnter%, copyNumber
return

copyNumber:											; copy text in active window and paste into 3CX

	SendInput, ^c

	ClipWait, 2
	if ErrorLevel
	{
		MsgBox, 8208, Error, Selection does not contain text, 2
		return
	}

	pnMatch := RegExMatch(Clipboard, pnRegEx, 1)
	if !pnMatch
	{
		MsgBox, % "Not able to format as phone number`n`nSelection: " clipboard
		return
	}

	pNumber := RegExReplace(Clipboard, pnRegEx, RegExOut, 1)

	MsgBox, 4132, Number, % "Is this the correct number?`n`n" pNumber, 3
	IfMsgBox, No
		return
	else
		Goto dial

	dial:
		if !debug0
			Run, "C:\ProgramData\3CXPhone for Windows\PhoneApp\3CXClickToCall.exe" "%pNumber%"

		if WinExist("ahk_exe 3CXWin8Phone.exe")
		{
			WinActivate
		}

return