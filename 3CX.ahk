3CXFocus(paste:=0)									; function that actually does stuff... defaults to just clearing any existing input
{
	global 3cxSleep
	if WinExist("ahk_exe 3CXWin8Phone.exe")
	{
		WinActivate
		WinActivate
		WinWaitActive, , , 1
		If ErrorLevel
		{
			MsgBox, 8208, Error, WinWaitActive Timed Out, cancelling
			return
		}
	} else {
		MsgBox, 8208, Not Running, 3CX is not running, cancelling
		return
	}

	Sleep, %3cxSleep%

	SendInput, {Esc}								; clear text from 3CX window

	if paste
	{
		SendInput, ^v 								; send copied text if 'paste' value is set
	}

return
}

#SingleInstance, force
Menu, Tray, Icon,  red_q_on_blue_bkgd.ico
Menu, Tray, Tip, QI Tools: 3CX

; Define INI file location
pathINI = %A_AppData%\Quest Integration\QI Tools.ini

; Read INI file (all times in ms); last values on each line are defaults
IniRead, 3cxSleep, %pathINI%, 3CX, 3cxSleep , 100				; Time to wait before sending input
IniRead, numEnter, %pathINI%, 3CX, numEnter, F11  				; Key to use for copy number
IniRead, phoneFocus, %pathINI%, 3CX, phoneFocus, F12 			; Key to use to bring 3CX to focus

Hotkey, %numEnter%, copyNumber
Hotkey, %phoneFocus%, pFocus
return

pFocus:

	3CXFocus()

return

copyNumber:											; copy text in active window and paste into 3CX

	SendInput, {End}+{Home}^c 						; select all text in active box

	3CXFocus(1)

return