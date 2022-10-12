#SingleInstance, force 							; Forces only one instance, allows to re-run script without reloading
Menu, Tray, Icon, images\WoosterGraphic.ico	    ; Icon for this script
Menu, Tray, Tip, WTS: Master Shortcut Script	; Change tooltip on icon in tray

; system verbs

; #NumLock::
; setNumLockState, AlwaysOn
; return

#c::Run, explore "C:\"

; #h::Run, explore "C:\Users\karl\Documents\GitHub"

; #n::Run, explore "C:\temp\Customers"
#n::Run, "C:\Users\KarlWooster\OneDrive - Wooster Technical Solutions\Documents\PdmVaultBrowser.exe"

; #n::Run, explorer.exe shell:appsFolder\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe!App

:*:kw@::karlwooster@gmail.com
:*:kt@::karl@woostertech.com
:*:km@::karl.wooster@wsu.edu
:*:sw@::samlsanderson@gmail.com
:*:wts*::Wooster Technical Solutions
:*:wsu*::Washington State University

; + & CapsLock::CapsLock
CapsLock & s::SendInput SOLIDWORKS
; CapsLock::Esc

; :*:cu/::C:\temp\Customers{enter}

; +!p::run, "cmd.exe" "/c presentationsettings.exe"

; Use with the Windows Action Center to clear all notifications; may do weird things if AC isn't up, will expand/collapse if AC is already blank
#z::Send {shift down}{tab}{tab}{shift up}{space}{esc}

; A quick way to make a window "always on top"
#Space:: WinSet, AlwaysOnTop, Toggle, A

; ^!+s::								; Fill out HGTV/diynetwork forms for Sam
;
; SendInput, Samantha{Tab}
; SendInput, Wooster{Tab}{Tab}
; SendInput, Pasco{Tab}
; SendInput, w{Tab}
; Sleep, 200
; SendInput, 99301{Tab}
; Sleep, 200
; SendInput, 5093862817{Tab}
; MsgBox, Choose Gender and click OK
; SendInput, {Tab}
; SendInput, {Down 7}{Tab}
; Sleep, 200
; SendInput, 10{Tab}1986{Tab}{Tab}
; SendInput, {Down 8}{Tab}
;
; Return
;
; ^!+k::								; Fill out HGTV/diynetwork forms for Karl
;
; SendInput, Karl{Tab}
; SendInput, Wooster{Tab}{Tab}
; SendInput, 7711 Thetis Dr{Tab}
; SendInput, Pasco{Tab}
; SendInput, w{Tab}
; Sleep, 200
; SendInput, 99301{Tab}
; Sleep, 200
; SendInput, 5098761792{Tab}
; MsgBox, Choose Gender and click OK
; SendInput, {Tab}
; SendInput, {Down 4}{Tab}
; Sleep, 200
; SendInput, 11{Tab}1985{Tab}{Tab}
; SendInput, {Down 8}{Tab}
;
; Return
