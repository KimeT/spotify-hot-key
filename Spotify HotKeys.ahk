#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance Force
#WinActivateForce
Menu, Tray, Tip, Spotify HotKeys:`nAlt+Up: Open/Maximize/Minimize Spotify`nAlt+Down: Play/Pause`nAlt+Left: Previous`nAlt+Right: Next

/*
Testing stuff, see if could be run in Debug mode
*/

;DetectHiddenWindows, On
;If WinExist("ahk_exe Spotify.exe")
;	MsgBox, , Info, Spotify is already running, 3
;else
;	MsgBox, , Info, Spotify is not yet running, 3
;DetectHiddenWindows, Off

/*
Functions
*/

HideSplashText() {
	SplashTextOff
	return
}

ShowSplashText(title, text, delay) {
	WinGetPos, X, Y, Width, Height, A
	SplashTextOn, Width / 3, 160, %title%, `n%text%
	SetTimer, HideSplashText, %delay%
	return
}

ShowNowPlaying(playing) {
	ShowSplashText("Spotify - Now playing", playing, 2000)
	return
}

CopyNowPlayingToClipBoard() {
	clipboard := GetNowPlaying()
	ShowSplashText("Copied to clipboard: Spotify - Now playing", clipboard, 2000)
	return
}

GetNowPlaying() {
	; TODO: Handle Spotify not open / not playing situations!
	DetectHiddenWindows, On
	WinGet, winInfo, List, ahk_exe Spotify.exe
	indexer := 3
	thisID := winInfo%indexer%
	WinGetTitle, nowPlaying, ahk_id %thisID%
	DetectHiddenWindows, Off
	return %nowPlaying%
}

/*
Hotkeys
*/

!Left::Media_Prev
!Right::Media_Next
!Down::Media_Play_Pause
!Up::
DetectHiddenWindows, On
IfWinExist ahk_exe Spotify.exe
{
	;MsgBox, , Info, Spotify already running, 3
	IfWinActive ahk_exe Spotify.exe
	{
		MsgBox, , Info, Spotify is running & active, 1
		;Sleep, 1
		;WinMinimize
		WinHide
		WinClose
		WinActivate, ahk_class Shell_TrayWnd ; This seems to do the trick, investigate if others (WinHide / WinClose) are unnecessary and if activating Spotify window needs modifications
	}
	else
	{
		MsgBox, , Info, Spotify is running but not active, 1
		;Sleep, 1
		IfWinNotActive ahk_exe Spotify.exe
		{
/* 			run Spotify.exe
			;WinWait, Spotify, , 3
			WinWaitActive, Spotify, , 3
			if ErrorLevel
			{
				MsgBox, , Error, WinWait timed out: Spotify, 3
				return
			}
			else
			{
				MsgBox, , Info, WinWait succeeded: Spotify, 3
				WinActivate
			}
			;;WinShow
			WinActivate
			WinRestore
 */
			run Spotify.exe
			WinWaitActive, Spotify, , 3
			WinActivate

			/* WinGet, winInfo, List, ahk_exe Spotify.exe
			indexer := 3
			ind := 3
			thisID := winInfo%indexer%
			spotifyID := winInfo%ind%
			;MsgBox, , Info, Spotify HWND:`n%winInfo%`n%spotifyID%`n%thisID%, 3
			WinShow, ahk_id %spotifyID%
			WinActivate, ahk_id %spotifyID%
			;WinShow, ahk_id %thisID%
			;WinActivate, ahk_id %thisID%
			 */
		}
	}
}
else
{
	;MsgBox, , Info, Spotify is not running, 3
	;Spotify installation path MUST be in PATH environment variable or otherwise known
	run Spotify.exe
}
DetectHiddenWindows, Off
^!n::
{
	ShowNowPlaying(GetNowPlaying())
	return
}
^!c::
{
	CopyNowPlayingToClipBoard()
	return
}
^!x::
{
	MsgBox, , TODO, Close Spotify, 3
	return
}
return