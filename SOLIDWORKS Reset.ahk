#SingleInstance, force 								; Forces only one instance, allows to re-run script without reloading
Menu, Tray, Icon, images\red_q_on_blue_bkgd.ico		; Icon for this script
Menu, Tray, Tip, QI Tools: SOLIDWORKS Reset	 		; Change tooltip on icon in tray

#Include SW_Reset_Properties.ahk 					; Read values for path/process/program/other defaults

Process, Exist, %process_name%						; Check to make sure that it's running
If ErrorLevel {										; Returns 0 if no matching program
	ToolTip, Stopping %program_name%
	Process, Close, %process_name%

	Process, WaitClose, %process_name%, 5				; Ensure process is killed before continuing
	If ErrorLevel {
		MsgBox, 8208, Error, Unable to close %program_name%, 5
		Exit
	}
	ToolTip

	ToolTip, Starting %program_name%
	Run, %start_path%

	Process, Wait, %process_name%
	If not ErrorLevel {
		MsgBox, 8208, Error, "%program_name% Timed Out", 3
		Exit
	}

	Sleep, 3000											; Keep tooltip visible for 3 seconds after process is "up"
	ToolTip
}