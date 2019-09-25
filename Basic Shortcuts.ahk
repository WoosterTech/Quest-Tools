#SingleInstance, force 								; Forces only one instance, allows to re-run script without reloading
Menu, Tray, Icon, images\red_q_on_blue_bkgd.ico		; Icon for this script
Menu, Tray, Tip, QI Tools: Basic Shortcuts	 		; Change tooltip on icon in tray

#Include BSC_Properties.ahk

#HotkeyInterval %hkInterval%						; Defines interval for next line
#MaxHotkeysPerInterval %hkMaxPerInt%				; Sets maximum number of presses of hotkey per interval

if numLockOn {
	SetNumLockState, AlwaysOn
}