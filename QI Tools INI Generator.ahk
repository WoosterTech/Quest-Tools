defINILoc := % AppData "\Quest Integration\QI Tools.ini"

; INIexist := FileExist(defINILoc)

QuickStatusChange.hcSleep := 50
QuickStatusChange.teamsSleep := 250

MsgBox, % QuickStatusChange.hcSleep

; sectionList := QuickStatusChange.hcSleep: 50, QuickStatusChange.teamsSleep: 250

; [QuickStatusChange]
; #hcSleep=50
; #teamsSleep=250
; #3cxSleep=100
; #buttonAvail="30,45"
; #posAvail="30,80"
; #posAway="30,120"
; #posDND="30,155"
; #awayInterval=15
; #roundInterval=5
; #onCallPos="80,500"
; #onCallColors="0x0000FF,0x575757,0xC1C1C1,0xFF0000"

; [3CX]
; #3cxSleep=100
; #numEnter=F11
; #phoneFocus=F12
; #pnRegEx := "^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$"
; #RegExOut := "($2) $3-$4"
; #debug0 : = 0

; [BasicShortcuts]
; #numLockOn=0
; #zoomEnable=0
; setVol=0
; ringWav="ringtone_-20db.wav"
; numLockOn=1

; [SW_Reset]
; #process_name="sldworks.exe"
; #program_name="SOLIDWORKS"
; start_path="C:\ProgramData\Microsoft\Windows\Start Menu\Programs\SOLIDWORKS 2019\SOLIDWORKS 2019.lnk"

; [RunAll]
; #fileNames="uninstall.exe,SOLIDWORKS Reset.exe,3DConnexion Reset.exe"
; #runPath="Quest Integration\QI Tools"
; [Test]
; Test1=test value 1
; Test2=test value
