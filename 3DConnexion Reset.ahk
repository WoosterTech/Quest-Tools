#SingleInstance, force 								; Forces only one instance, allows to re-run script without reloading
Menu, Tray, Icon, images\red_q_on_blue_bkgd.ico		; Icon for this script
Menu, Tray, Tip, QI Tools: 3DConnexion Reset	 	; Change tooltip on icon in tray

; #Include BSC_Properties.ahk

Process, Exist, 3DxService.exe
If ErrorLevel {
	ToolTip, Stopping 3DConnexion Driver
	Run, "C:\Program Files\3Dconnexion\3DxWare\3DxWinCore64\3DxService.exe" "-quiet -shutdown"

	Process, WaitClose, 3DxService.exe
}

ToolTip, Starting 3DConnexion Driver
Run, "C:\Program Files\3Dconnexion\3DxWare\3DxWinCore64\3DxService.exe"

Process, Wait, 3DxService.exe, 5
If not ErrorLevel {
	MsgBox, 8208, Error, "3DConnexion Driver Timed Out"
}

ToolTip
MsgBox, 4160, Driver Reset, 3DConnexion Driver Reset, 3