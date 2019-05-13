#SingleInstance, force
Menu, Tray, Icon,  images\red_q_on_blue_bkgd.ico
Menu, Tray, Tip, QI Tools: 3CX

#Include 3CX_Properties.ahk

Hotkey, %numEnter%, copyNumber
Hotkey, %phoneFocus%, pFocus
return

pFocus:

	QIFunctions_3CXFocus()

return

copyNumber:											; copy text in active window and paste into 3CX

	SendInput, ^c

	QIFunctions_3CXFocus(1)

return