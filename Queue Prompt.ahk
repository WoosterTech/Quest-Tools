#SingleInstance, force 								; Forces only one instance, allows to re-run script without reloading
Menu, Tray, Icon, images\red_q_on_blue_bkgd.ico		; Icon for this script
Menu, Tray, Tip, QI Tools: Queue Prompt		 		; Change tooltip on icon in tray

#Include qp_properties.ahk

; FormatTime, humanTime, %startTime%, h:mm tt

FormatTime, timeNow, , HH:mm

; timeNow := A_Now

EnvSub, timeNow, %startTime%

; MsgBox, %timeNow%

if (timeNow < 0)
{
	MsgBox, 4132, Log In, % "Would you like to be logged`ninto the queue at " startTime "?"
}
Else
{
	MsgBox, 4132, Log In, % "It is after " startTime "`nWould you like to be logged into the queue?"
}

return