#SingleInstance, force 								; Forces only one instance, allows to re-run script without reloading
Menu, Tray, Icon, images\red_q_on_blue_bkgd.ico		; Icon for this script
Menu, Tray, Tip, QI Tools: Basic Shortcuts	 		; Change tooltip on icon in tray

#Include BSC_Properties.ahk

#HotkeyInterval %hkInterval%						; Defines interval for next line
#MaxHotkeysPerInterval %hkMaxPerInt%				; Sets maximum number of presses of hotkey per interval

if numLockOn {
	SetNumLockState, AlwaysOn
}

; Overwrites ringtone wav file with file indicated in ini file
; Source wav file must be located in %appdata%\Quest Integration
if setVol {
	sFile := % ProgramFiles "\Quest Integration\QI Tools\sounds\" ringWav												; Sets source file location
	dFile := % A_AppDataCommon "\3CXPhone for Windows\PhoneApp\Sounds\ringtone.wav"					; Sets destination location (hard coded)

	fExist := FileExist(sFile)																		; Verify source file exists
	if fExist {
		FileCopy, % sFile, % dFile, 1																; Copy WITH overwrite
		if ErrorLevel {
			MsgBox, 8208, Unable to Copy, % ErrorLevel 												; Shows how many files failed copying. Should only ever be 1 (only 1 file attempted)
		}
	} else {
		MsgBox, 8208, No File Exists, % "Unable to locate " sFile ".`n`nRingtone not updated."
	}
}

#If zoomEnable										; Only set these hotkeys if zoomEnable is '1' in ini file
WheelRight::#=										; Zooms in with Windows Magnifier
WheelLeft::#-										; Zooms out with Windows Magnifier