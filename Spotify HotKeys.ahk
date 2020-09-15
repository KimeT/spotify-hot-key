#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance Force
#WinActivateForce
Menu, Tray, Tip, Spotify HotKeys:`nAlt+Up: Open/Maximize/Minimize Spotify`nAlt+Down: Play/Pause`nAlt+Left: Previous`nAlt+Right: Next

;DetectHiddenWindows, On
;If WinExist("ahk_exe Spotify.exe")
;	MsgBox, , Info, Spotify is already running, 3
;else
;	MsgBox, , Info, Spotify is not yet running, 3
;DetectHiddenWindows, Off

!Left::Media_Prev
!Right::Media_Next
!DOWN::Media_Play_Pause
!UP::
DetectHiddenWindows, On
IfWinExist ahk_exe Spotify.exe
{
	;MsgBox, , Info, Spotify already running, 3
	IfWinActive ahk_exe Spotify.exe
	{
		;MsgBox, , Info, Spotify is active, 1
		;Sleep, 1
		;WinMinimize
		WinHide
		WinClose
	}
	else
	{
		;MsgBox, , Info, Spotify is not active, 1
		;Sleep, 1
		IfWinNotActive ahk_exe Spotify.exe
		{
			run Spotify.exe
			;WinWait, Spotify, , 3
			WinWaitActive, Spotify, , 3
			;WinShow
			WinActivate
		}
	}
}
else
{
	;Spotify installation path MUST be in PATH environment variable or otherwise known
	run Spotify.exe
}
DetectHiddenWindows, Off
return