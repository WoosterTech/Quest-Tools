3CXFocus(paste:=0)									; function that actually does stuff... defaults to just clearing any existing input
{
	if WinExist("ahk_exe 3CXWin8Phone.exe")
	{
		winid := WinExist("ahk_exe 3CXWin8Phone.exe")
	}

	if winid
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

	Sleep, 500

	SendInput, {Esc}								; clear text from 3CX window

	if paste
	{
		SendInput, ^v 								; send copied text if 'paste' value is set
	}

return
}

#SingleInstance, force

^!\:: 												; ctrl+alt+\ switches to 3CX and readies it for number entry (if on number page)
F12::

	3CXFocus()

return

F11::												; copy text in active window and paste into 3CX

	SendInput, {End}+{Home}^c 						; select all text in active box

	3CXFocus(1)

return