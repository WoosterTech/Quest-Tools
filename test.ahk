#SingleInstance, force
Menu, Tray, Icon,  images\red_q_on_blue_bkgd.ico
Menu, Tray, Tip, QI Tools: 3CX

SetTitleMatchMode 2
DetectHiddenWindows, On

F3::						; Switch to Outlook inbox
IfWinExist, - Outlook
{
	WinShow
	WinActivate
	SendInput ^1
} else {
	run Outlook.exe /select outlook:inbox
}
return

F4::						; Switch to Outlook calendar
IfWinExist, - Outlook
{
	WinShow
	WinActivate
	SendInput ^2
} else {
	run Outlook.exe /select outlook:calendar
}
return

F5::
IfWinExist, - Outlook
{
	IfWinNotActive
	{
		WinShow
		WinActivate
	} else {
		WinMinimize
		WinHide
	}
} else {
	run Outlook.exe
}
return