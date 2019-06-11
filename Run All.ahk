#SingleInstance, force 								; Forces only one instance, allows to re-run script without reloading
; Menu, Tray, Icon, images\red_q_on_blue_bkgd.ico		; Icon for this script
Menu, Tray, Tip, QI Tools: Run All 			 		; Change tooltip on icon in tray

#Include ra_properties.ahk

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
		try
		{
			ToolTip, % "Starting`n" A_LoopFileName
			Run, %A_LoopFileName% /restart 						; Run app
		} catch e {
			MsgBox, 16, Error, % "Failed to start """ A_LoopFileName """`n" e.message
		}
	}
}

ToolTip