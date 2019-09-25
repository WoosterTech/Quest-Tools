#SingleInstance, force
Menu, Tray, Icon,  images\red_q_on_blue_bkgd.ico
Menu, Tray, Tip, QI Tools: 3CX

#Include 3CX_Properties.ahk

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