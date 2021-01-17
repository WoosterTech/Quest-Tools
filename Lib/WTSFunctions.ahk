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

WTSFunctions_winTogg()
{
	WinGet, Style, Style

	IfWinNotActive
	{
		If !(Style & 0x10000000)
			WinRestore
		WinActivate
	} else {
		WinMinimize
		WinHide
	}

	return
}