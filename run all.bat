@echo off

set run_q=true

for /r "." %%a in (*.exe) do (
	echo %%~na
	rem set run_q=true
	rem echo Post set "!run_q!"
	if %%~na EQU uninstall set run_q=false
	rem rem if %%~na EQU SOLIDWORKS set run_q=false
	rem rem if %%~na EQU 3DConnexion set run_q=false
	rem echo Post if ^!run_q^!
	if %run_q% == true @echo evaluated to true
	rem (
	rem 	rem start "" "%%~fa"
	rem 	echo Starting program
	rem ) else (
	rem 	echo "This application should not be auto-run"
	rem )
)
rem pause