@echo off

for /r "." %%a in (*.exe) do (
	rem echo %%~na
	if %%~na EQU uninstall (
		echo "No need to run the uninstaller!"
	) else (
		start "" "%%~fa"
	)
)

rem pause