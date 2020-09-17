#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance Force
#WinActivateForce
OutputDebug, SpotifyHotKeys: Started
FileAppend SpotifyHotKeys: Started,* ;* goes to stdout
OnExit("ExitFunc")
Menu, Tray, Tip, Spotify HotKeys:`nAlt+Up: Open/Maximize/Minimize Spotify`nAlt+Down: Play/Pause`nAlt+Left: Previous`nAlt+Right: Next

/*
Startup testing for Debug
*/

DetectHiddenWindows, On
If WinExist("ahk_exe Spotify.exe")
	OutputDebug, SpotifyHotKeys: Spotify is already running
else
	OutputDebug, SpotifyHotKeys: Spotify is not yet running
DetectHiddenWindows, Off

/*
Functions
*/

ExitFunc(ExitReason, ExitCode)
{
	OutputDebug, SpotifyHotKeys: Stopped
	return
}

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

CopyNowPlayingToClipBoard(showSplash) {
	clipboard := GetNowPlaying()
	if showSplash
	{
		ShowSplashText("Copied to clipboard: Spotify - Now playing", clipboard, 2000)
	}
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
{
	DetectHiddenWindows, On
	IfWinExist ahk_exe Spotify.exe
	{
		OutputDebug, Spotify is already running
		IfWinActive ahk_exe Spotify.exe
		{
			OutputDebug, Spotify is running & active
			;WinMinimize
			WinHide
			WinClose
			WinActivate, ahk_class Shell_TrayWnd ; This seems to do the trick, investigate if others (WinHide / WinClose) are unnecessary and if activating Spotify window needs modifications
			OutputDebug, Spotify Window set: Hidden
		}
		else
		{
			OutputDebug, Spotify is running but not active
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
		OutputDebug, Spotify is currently not running
		;Spotify installation path MUST be in PATH environment variable or otherwise known
		run Spotify.exe
		OutputDebug, Spotify opened
	}
	DetectHiddenWindows, Off
	return
}
^!n::ShowNowPlaying(GetNowPlaying())
^!c::CopyNowPlayingToClipBoard(True)
^!x::
{
	MsgBox, , TODO, Close Spotify, 3
	return
}

