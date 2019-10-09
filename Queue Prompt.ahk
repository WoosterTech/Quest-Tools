#SingleInstance, force 								; Forces only one instance, allows to re-run script without reloading
Menu, Tray, Icon, images\red_q_on_blue_bkgd.ico		; Icon for this script
Menu, Tray, Tip, QI Tools: Queue Prompt		 		; Change tooltip on icon in tray

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Initialization ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Define INI file location
pathINI = %A_AppData%\Quest Integration\QI Tools.ini

; Section of INI file for 3CX
iniSection = 3CX

; Initialize iniProps
iniProps := {}

; Properties from INI file with their defaults
iniProps["startTime"] := "08:00"		; Excluded files (these won't run automatically)
iniProps["queueOn"] := "*62"										; Program path
iniProps["queueOff"] := "*63"

iniProps := QIFunctions_readINI(pathINI, iniProps, iniSection)

fName_List := StrSplit(iniProps["fileNames"], ",")										; Separate file names into array (excluded files)

startTime := iniProps["startTime"]
queueOn := iniProps["queueOn"]
queueOff := iniProps["queueOff"]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Main Code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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