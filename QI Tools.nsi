# This installs two files, 3cx.exe and red_q_on_blue_bkgd.ico, creates a start menu shortcut, builds an uninstaller, and
# adds uninstall information to the registry for Add/Remove Programs
 
# To get started, put this script into a folder with the two files (3cx.exe, red_q_on_blue_bkgd.ico, and license.rtf -
# You'll have to create these yourself) and run makensis on it
 
# If you change the names "3cx.exe", "red_q_on_blue_bkgd.ico", or "license.rtf" you should do a search and replace - they
# show up in a few places.
# All the other settings can be tweaked by editing the !defines at the top of this script
!define APPNAME "QI Tools"
!define COMPANYNAME "Quest Integration"
!define DESCRIPTION "Helpful tools for Quest Integration employees"
# These three must be integers
!define VERSIONMAJOR 0
!define VERSIONMINOR 0
!define VERSIONBUILD 20
# These will be displayed by the "Click here for support information" link in "Add/Remove Programs"
# It is possible to use "mailto:" links in here to open the email client
; !define HELPURL "http://..." # "Support Information" link
; !define UPDATEURL "http://..." # "Product Updates" link
; !define ABOUTURL "http://..." # "Publisher" link
# This is the size (in kB) of all the files copied into "Program Files"
; !define INSTALLSIZE 7233
 
; RequestExecutionLevel admin ;Require admin rights on NT6+ (When UAC is turned on)
 
InstallDir "$PROGRAMFILES\${COMPANYNAME}\${APPNAME}"
 
# rtf or txt file - remember if it is txt, it must be in the DOS text format (\r\n)
; LicenseData "license.rtf"
# This will be in the installer/uninstaller's title bar
Name "${COMPANYNAME} - ${APPNAME}"
Icon "images\red_q_on_blue_bkgd.ico"
outFile "QI Tools.exe"
RequestExecutionLevel admin
 
!include LogicLib.nsh
!include FileFunc.nsh
!include nsProcess.nsh
!include nsDialogs.nsh
!include Sections.nsh
!include MUI2.nsh

!define MUI_ICON "images\red_q_on_blue_bkgd.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "image\red_q_on_blue_bkgd.bmp"
!define MUI_FINISHPAGE_RUN "$INSTDIR\Run All.exe"
!define MUI_FINISHPAGE_RUN_TEXT "Run All Installed Scripts"

Insttype "Standard Install"
Insttype "Full Install"
; Insttype "Custom Install"
 
# Just three pages - license agreement, install location, and installation
; page license
; page custom nsDialogsCustom
; page components
; page directory
; Page instfiles
 
; !macro VerifyUserIsAdmin
; UserInfo::GetAccountType
; pop $0
; ${If} $0 != "admin" ;Require admin rights on NT4+
;         messageBox mb_iconstop "Administrator rights required!"
;         setErrorLevel 740 ;ERROR_ELEVATION_REQUIRED
;         quit
; ${EndIf}
; !macroend
 
; function .onInit
; 	setShellVarContext all
; 	; !insertmacro VerifyUserIsAdmin
; functionEnd

Function .onInit
	setOutPath $INSTDIR
FunctionEnd
 
; Section "Common Files (Required)"
; 	SectionIn RO

; 	setOutPath $INSTDIR

; 	file "images\red_q_on_blue_bkgd.ico"

; 	setOutPath "$APPDATA\${COMPANYNAME}"

; 	file "QI Tools.ini"

; SectionEnd

section "Common Files (Required)"
	SectionIn RO

	# Files for the install directory - to build the installer, these should be in the same directory as the install script (this file)
	; setOutPath $INSTDIR
	# Files added here should be removed by the uninstaller (see section "uninstall")
	; file "3cx.exe"
	; file "GMSearch.exe"
	; file "Quick Status Change.exe"
	; file "Window Switching.exe"
	; file "Basic Shortcuts.exe"
	
	# Add any other files for the install directory (license files, app data, etc) here
	CreateDirectory "$INSTDIR"
	CreateDirectory "$INSTDIR\images"
	file "Run All.exe"
	file /oname=images\red_q_on_blue_bkgd.ico images\red_q_on_blue_bkgd.ico
	file /oname=images\q_on_red_bkgd.ico images\q_on_red_bkgd.ico

	${GetSize} "$INSTDIR" "/S=0K" $0 $1 $2
	IntFmt $0 "0x%08X" $0
	!define INSTALLSIZE $0


	setOutPath "$APPDATA\${COMPANYNAME}"

	file "QI Tools.ini"
	file sounds\ringtone_-20db.wav
	file sounds\ringtone_og.wav

 
	# Uninstaller - See function un.onInit and section "uninstall" for configuration
	writeUninstaller "$INSTDIR\uninstall.exe"
 
	# Start Menu
	createDirectory "$SMPROGRAMS\${COMPANYNAME}"
	createShortCut "$SMPROGRAMS\${COMPANYNAME}\Run All.lnk" "$INSTDIR\Run All.exe" "" "$INSTDIR\red_q_on_blue_bkgd.ico"
	; createShortCut "$SMPROGRAMS\${COMPANYNAME}\GoldMine Search.lnk" "$INSTDIR\GMSearch.exe" "" "$INSTDIR\red_q_on_blue_bkgd.ico"
	; createShortCut "$SMPROGRAMS\${COMPANYNAME}\Quick Status Change.lnk" "$INSTDIR\Quick Status Change.exe" "" "$INSTDIR\red_q_on_blue_bkgd.ico"
	; createShortCut "$SMPROGRAMS\${COMPANYNAME}\Window Switching.lnk" "$INSTDIR\Window Switching.exe" "" "$INSTDIR\red_q_on_blue_bkgd.ico"
	; createShortCut "$SMPROGRAMS\${COMPANYNAME}\Basic Shortcuts.lnk" "$INSTDIR\Basic Shortcuts.exe" "" "$INSTDIR\red_q_on_blue_bkgd.ico"

	; createShortCut "$SMSTARTUP\3CX.lnk" "$INSTDIR\3cx.exe" "" "$INSTDIR\red_q_on_blue_bkgd.ico"
	; createShortCut "$SMSTARTUP\Quick Status Change.lnk" "$INSTDIR\Quick Status Change.exe" "" "$INSTDIR\red_q_on_blue_bkgd.ico"
 
	# Registry information for add/remove programs
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "DisplayName" "${APPNAME}"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "QuietUninstallString" "$\"$INSTDIR\uninstall.exe$\" /S"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "InstallLocation" "$\"$INSTDIR$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "DisplayIcon" "$\"$INSTDIR\images\red_q_on_blue_bkgd.ico$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "Publisher" "$\"${COMPANYNAME}$\""
	; WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "HelpLink" "$\"${HELPURL}$\""
	; WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "URLUpdateInfo" "$\"${UPDATEURL}$\""
	; WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "URLInfoAbout" "$\"${ABOUTURL}$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "DisplayIcon" "$\"$INSTDIR\images\red_q_on_blue_bkgd.ico$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "DisplayVersion" "${VERSIONMAJOR}.${VERSIONMINOR}.${VERSIONBUILD}"
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "VersionMajor" ${VERSIONMAJOR}
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "VersionMinor" ${VERSIONMINOR}

	# There is no option for modifying or repairing the install
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "NoModify" 1
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "NoRepair" 1

	# Set the INSTALLSIZE constant (!defined at the top of this script) so Add/Remove Programs can accurately report the size
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "EstimatedSize" ${INSTALLSIZE}
sectionEnd

Section "3CX Click-to-Dial"
	SectionIn 1 2

	setOutPath $INSTDIR

	file "3cx.exe"

	createShortCut "$SMPROGRAMS\${COMPANYNAME}\3CX Click-to-Dial.lnk" "$INSTDIR\3cx.exe" "" "$INSTDIR\images\red_q_on_blue_bkgd.ico"		; Add to start menu
	createShortCut "$SMSTARTUP\3CX Click-to-Dial.lnk" "$INSTDIR\3cx.exe" "" "$INSTDIR\images\red_q_on_blue_bkgd.ico"						; Launch on startup

SectionEnd

Section "Quick Status Change"
	SectionIn 1 2

	setOutPath $INSTDIR

	file "Quick Status Change.exe"
	file /oname=images\q_on_green_bkgd.ico images\q_on_green_bkgd.ico
	file /oname=images\q_on_red_bkgd.ico images\q_on_red_bkgd.ico
	file /oname=images\q_on_yellow_bkgd.ico images\q_on_yellow_bkgd.ico

	createShortCut "$SMPROGRAMS\${COMPANYNAME}\Quick Status Change.lnk" "$INSTDIR\Quick Status Change.exe" "" "$INSTDIR\images\red_q_on_blue_bkgd.ico"		; Add to start menu
	createShortCut "$SMSTARTUP\Quick Status Change.lnk" "$INSTDIR\Quick Status Change.exe" "" "$INSTDIR\images\red_q_on_blue_bkgd.ico"						; Launch on startup

SectionEnd

Section "SOLIDWORKS Reset"
	SectionIn 2

	setOutPath $INSTDIR

	file "SOLIDWORKS Reset.exe"

	createShortCut "$SMPROGRAMS\${COMPANYNAME}\SOLIDWORKS Reset.lnk" "$INSTDIR\SOLIDWORKS Reset.exe" "" "$INSTDIR\images\red_q_on_blue_bkgd.ico"		; Add to start menu

SectionEnd

Section "3DConnexion Reset"
	SectionIn 2

	setOutPath $INSTDIR

	file "3DConnexion Reset.exe"

	createShortCut "$SMPROGRAMS\${COMPANYNAME}\3DConnexion Reset.lnk" "$INSTDIR\3DConnexion Reset.exe" "" "$INSTDIR\images\red_q_on_blue_bkgd.ico"		; Add to start menu

SectionEnd

Section "Window Switching"
	SectionIn 2

	setOutPath $INSTDIR

	file "Window Switching.exe"

	createShortCut "$SMPROGRAMS\${COMPANYNAME}\Window Switching.lnk" "$INSTDIR\Window Switching.exe" "" "$INSTDIR\images\red_q_on_blue_bkgd.ico"		; Add to start menu
	createShortCut "$SMSTARTUP\Window Switching.lnk" "$INSTDIR\Window Switching.exe" "" "$INSTDIR\images\red_q_on_blue_bkgd.ico"						; Launch on startup

SectionEnd

Section "Basic Shortcuts"
	SectionIn 2

	setOutPath $INSTDIR

	file "Basic Shortcuts.exe"

	createShortCut "$SMPROGRAMS\${COMPANYNAME}\Basic Shortcuts.lnk" "$INSTDIR\Basic Shortcuts.exe" "" "$INSTDIR\images\red_q_on_blue_bkgd.ico"		; Add to start menu
	createShortCut "$SMSTARTUP\Basic Shortcuts.lnk" "$INSTDIR\Basic Shortcuts.exe" "" "$INSTDIR\images\red_q_on_blue_bkgd.ico"						; Launch on startup

SectionEnd

; !insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
 
# Uninstaller
 
function un.onInit
	; SetShellVarContext all
 
	#Verify the uninstaller - last chance to back out
	MessageBox MB_OKCANCEL "Permanantly remove ${APPNAME}?" IDOK next
		Abort
	next:
	; !insertmacro VerifyUserIsAdmin
functionEnd
 
section "uninstall"
 
 	# Kill all processes
 	${nsProcess::KillProcess} "3cx.exe" $R0
 	${nsProcess::KillProcess} "GMSearch.exe" $R1
 	${nsProcess::KillProcess} "Quick Status Change.exe" $R2
 	${nsProcess::KillProcess} "Window Switching.exe" $R3
 	${nsProcess::KillProcess} "Basic Shortcuts.exe" $R4

	# Remove Start Menu launcher
	delete "$SMPROGRAMS\${COMPANYNAME}\3CX Click-to-Dial.lnk"
	delete "$SMPROGRAMS\${COMPANYNAME}\GoldMine Search.lnk"
	delete "$SMPROGRAMS\${COMPANYNAME}\Quick Status Change.lnk"
	delete "$SMPROGRAMS\${COMPANYNAME}\Teams Status Change.lnk"
	delete "$SMPROGRAMS\${COMPANYNAME}\Window Switching.lnk"
	delete "$SMPROGRAMS\${COMPANYNAME}\Basic Shortcuts.lnk"
	delete "$SMPROGRAMS\${COMPANYNAME}\Run All.lnk"
	delete "$SMPROGRAMS\${COMPANYNAME}\3DConnexion Reset.lnk"
	delete "$SMPROGRAMS\${COMPANYNAME}\SOLIDWORKS Reset.lnk"
	delete "$SMSTARTUP\3CX Click-to-Dial.lnk"
	delete "$SMSTARTUP\Quick Status Change.lnk"
	delete "$SMSTARTUP\GoldMine Search.lnk"
	delete "$SMSTARTUP\Window Switching.lnk"
	delete "$SMSTARTUP\Basic Shortcuts.lnk"
	; delete "$SMPROGRAMS\${COMPANYNAME}\${APPNAME}.lnk"

	# Try to remove the Start Menu folder - this will only happen if it is empty
	rmDir "$SMPROGRAMS\${COMPANYNAME}"
 
	# Remove files
	delete "$INSTDIR\3cx.exe"
	delete "$INSTDIR\GMSearch.exe"
	delete "$INSTDIR\Teams Status.exe"
	delete "$INSTDIR\Window Switching.exe"
	delete "$INSTDIR\Basic Shortcuts.exe"
	delete "$INSTDIR\Quick Status Change.exe"
	delete "$INSTDIR\3DConnexion Reset.exe"
	delete "$INSTDIR\SOLIDWORKS Reset.exe"
	delete "$INSTDIR\run all.bat"
	delete "$INSTDIR\Run All.exe"
	delete "$INSTDIR\images\red_q_on_blue_bkgd.ico"
	delete "$INSTDIR\images\q_on_red_bkgd.ico"
	delete "$INSTDIR\images\q_on_yellow_bkgd.ico"
	delete "$INSTDIR\images\q_on_green_bkgd.ico"
 
	# Always delete uninstaller as the last action
	delete $INSTDIR\uninstall.exe
 
	# Try to remove the install directory - this will only happen if it is empty
	rmDir $INSTDIR\images
	rmDir $INSTDIR
 
	# Remove uninstaller information from the registry
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}"
sectionEnd