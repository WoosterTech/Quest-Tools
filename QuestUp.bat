IF NOT EXIST "%allusersprofile%\3CXPhone for Windows\PhoneApp\Sounds\ringtone.wav.backup" (
	COPY "%allusersprofile%\3CXPhone for Windows\PhoneApp\Sounds\ringtone.wav" "%allusersprofile%\3CXPhone for Windows\PhoneApp\Sounds\ringtone.wav.backup"
)
	
COPY "sounds\%1" "%allusersprofile%\3CXPhone for Windows\PhoneApp\Sounds\ringtone.wav"