#SingleInstance, force 								; Forces only one instance, allows to re-run script without reloading
Menu, Tray, Icon, images\red_q_on_blue_bkgd.ico		; Icon for this script
Menu, Tray, Tip, QI Tools: Run All 			 		; Change tooltip on icon in tray

#Include ra_properties.ahk

counter := 0

Loop, Files, % A_ProgramFiles "\" runPath "\*.exe", R 	; Loop over all EXE files in Quest folder
{
	f_skip := false 								; Set "skip" value to false (assume we WILL be running by default)
	Loop % fName_List.MaxIndex()					; Loop over list of excluded files
	{
		If fName_List[A_Index] == A_LoopFileName 	; Check if EXE matches excluded list
			f_skip := true 							; Set "skip" to true if a match
	}

	If not f_skip									; If no match (to excluded list) is found
	{
		Process, Exist, %A_LoopFileName%			; Check if already running
		While ErrorLevel
		{
			ToolTip, % "Closing`n`" A_LoopFileName
			Process, Close, %A_LoopFileName%		; Close (but only if already running), and only 1 instance
			Process, Exist, %A_LoopFileName%

			counter += 1
		}

		Process, WaitClose, %A_LoopFileName%, 5 ; Wait 5 seconds for app to close
		If ErrorLevel 							; If not closed in 5 seconds (often if multiple instances were open)
		{
			MsgBox, % "Unable to close " A_LoopFileName "`n`nEnding Run All"
			Exit
		}

		ToolTip, % "Starting`n" A_LoopFileName
		Run, %A_LoopFileName% 						; Run app
	}
}

ToolTip, % counter " script(s) closed"
Sleep, 2000

ToolTip