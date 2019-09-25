@echo off
IF NOT EXIST "%allusersprofile%\3CXPhone for Windows\PhoneApp\Sounds\ringtone.wav.backup" (
	COPY "%allusersprofile%\3CXPhone for Windows\PhoneApp\Sounds\ringtone.wav" "%allusersprofile%\3CXPhone for Windows\PhoneApp\Sounds\ringtone.wav.backup"
)

rem ECHO %1 >> c:\log.log	
COPY "sounds\%1" "%allusersprofile%\3CXPhone for Windows\PhoneApp\Sounds\ringtone.wav"