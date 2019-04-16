#SingleInstance, force 							; Forces only one instance, allows to re-run script without reloading
Menu, Tray, Icon, images\red_q_on_blue_bkgd.ico	; Icon for this script
Menu, Tray, Tip, QI Tools: Quick Status Change 	; Change tooltip on icon in tray
CoordMode, Mouse, Client

#Include QSC_Properties.ahk

^F1::		; Available
	QIFunctions_StatusChange("available", codeF1, changeTeams, change3CX)
	Menu, Tray, Icon, images\q_on_green_bkgd.ico
return

^F2::		; Away/BRB
	QIFunctions_StatusChange("brb", codeF2, changeTeams, change3CX)
	Menu, Tray, Icon, images\q_on_yellow_bkgd.ico
return

^F3::		; Do not disturb (generic)
	QIFunctions_StatusChange("dnd", codeF3, changeTeams, change3CX)
	Menu, Tray, Icon, images\q_on_red_bkgd.ico
return

^F4::		; Busy/On-phone
	QIFunctions_StatusChange("busy", codeF3, changeTeams, change3CX)
	Menu, Tray, Icon, images\q_on_red_bkgd.ico
return

^F5::		; Lunch
	QIFunctions_StatusChange("brb", codeF5, changeTeams, change3CX)
	Menu, Tray, Icon, images\q_on_yellow_bkgd.ico
return

^F6::		; SB
	QIFunctions_StatusChange("dnd", codeF6, changeTeams, change3CX)
	Menu, Tray, Icon, images\q_on_red_bkgd.ico
return