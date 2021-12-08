WTSFunctions_readINI(iniPath, iniKeys, ini_section)					; Reads keys from defined INI file based on 'iniKeys'
{
	For key, value in iniKeys
	{
		IniRead, valCheck, %iniPath%, %ini_section%, %key%
		if (valCheck = "ERROR") {
			IniWrite, %value%, %iniPath%, %ini_Section%, %key%
			iniKeys[(key)] := value
		} else {
			iniKeys[(key)] := valCheck
		}
	}

	return iniKeys
}

WTSFunctions_winShow(WindHide := true)
{
	WinGet, Style, Style

	IfWinNotActive
	{
		WinGet, winid, ID
		DllCall("SwitchToThisWindow", "UInt", winid, "UInt", 1)		; This seems to be more reliable than WinRestore, woohoo!
	} else {
		WinMinimize
		If WindHide													; Allows for the INI file to control hiding if the app doesn't like it (fixed with DllCall I think)
			WinHide
	}

	return
}