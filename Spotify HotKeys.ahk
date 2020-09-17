#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance Force
#WinActivateForce
OutputDebug, SpotifyHotKeys: Started
OnExit("ExitFunc")
Menu, Tray, Tip, Spotify HotKeys:`nAlt+Up: Open/Maximize/Minimize Spotify`nAlt+Down: Play/Pause`nAlt+Left: Previous`nAlt+Right: Next

/*
Startup testing for Debug
*/

DetectHiddenWindows, On
If WinExist("ahk_exe Spotify.exe")
	If WinActive("ahk_exe Spotify.exe")
		OutputDebug, SpotifyHotKeys: Spotify is already running & active
	else
		OutputDebug, SpotifyHotKeys: Spotify is already running but not active
else
	OutputDebug, SpotifyHotKeys: Spotify is not yet running
DetectHiddenWindows, Off

/*
Functions
*/

ExitFunc(ExitReason, ExitCode) {
	OutputDebug, SpotifyHotKeys: Stopped
	return
}

HideSplashText() {
	OutputDebug, SpotifyHotKeys: HideSplashText called
	SplashTextOff
	return
}

ShowSplashText(title, text, delay) {
	OutputDebug, SpotifyHotKeys: ShowSplashText called
	WinGetPos, X, Y, Width, Height, A
	SplashTextOn, Width / 3, 160, %title%, `n%text%
	SetTimer, HideSplashText, %delay%
	return
}

ShowNowPlaying(playing) {
	OutputDebug, SpotifyHotKeys: ShowNowPlaying called
	ShowSplashText("Spotify - Now playing", playing, -2000)
	return
}

CopyNowPlayingToClipBoard(showSplash) {
	OutputDebug, SpotifyHotKeys: CopyNowPlayingToClipBoard called
	clipboard := GetNowPlaying()
	if showSplash
		ShowSplashText("Copied to clipboard: Spotify - Now playing", clipboard, -2000)
	return
}

GetNowPlaying() {
	OutputDebug, SpotifyHotKeys: GetNowPlaying called
	DetectHiddenWindows, On
	if WinExist("ahk_exe Spotify.exe")
	{
		WinGet, winInfo, List, ahk_exe Spotify.exe
		indexer := 3
		thisID := winInfo%indexer%
		WinGetTitle, nowPlaying, ahk_id %thisID%

		StartsWithSpotify := InStr(nowPlaying, "Spotify", CaseSensitive := True) = 1
		OutputDebug, SpotifyHotKeys: StartsWithSpotify = %StartsWithSpotify%
		NotContainsLine := Not InStr(nowPlaying, "-")
		OutputDebug, SpotifyHotKeys: NotContainsLine = %NotContainsLine%

		if StartsWithSpotify And NotContainsLine
		{
			nowPlaying = Spotify not playing
		}
	}
	else
	{
		nowPlaying = Spotify not running
	}
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
		IfWinActive ahk_exe Spotify.exe
		{
			OutputDebug, SpotifyHotKeys: Spotify is running & active...
			WinHide
			WinClose
			WinActivate, ahk_class Shell_TrayWnd ; This seems to do the trick, investigate if others (WinHide / WinClose) are unnecessary and if activating Spotify window needs modifications
			OutputDebug, SpotifyHotKeys: Spotify window set Hidden
		}
		else
		{
			OutputDebug, SpotifyHotKeys: Spotify is running but not active...
			IfWinNotActive ahk_exe Spotify.exe
			{
	/* 			run Spotify.exe
				;WinWait, Spotify, , 3
				WinWaitActive, Spotify, , 3
				if %ErrorLevel%
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
				;WinWaitActive, ahk_exe Spotify.exe, , 3
				WinGet, MinMaxState, MinMax
				OutputDebug, SpotifyHotKeys: Spotify window MinMaxState = %MinMaxState%
				WinSet, Top
				WinSet, Redraw
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
				OutputDebug, SpotifyHotKeys: Spotify window set Active
			}
		}
	}
	else
	{
		OutputDebug, SpotifyHotKeys: Spotify is not running...
		;Spotify installation path MUST be in PATH environment variable or otherwise known
		run Spotify.exe
		OutputDebug, SpotifyHotKeys: Spotify opened
	}
	DetectHiddenWindows, Off
	return
}
^!n::ShowNowPlaying(GetNowPlaying())
^!c::CopyNowPlayingToClipBoard(True)
^!x::
{
	DetectHiddenWindows, On
	if WinExist("ahk_exe Spotify.exe")
	{
		OutputDebug, SpotifyHotKeys: Spotify is currently running...
		LoopCount = 100
		LoopWait = 100
		LoopTimeout := Round(LoopCount * LoopWait / 1000)

		Process, Close, Spotify.exe
		Loop %LoopCount%
		{
			Process, Exist, Spotify.exe
			if %ErrorLevel%
			{
				OutputDebug, SpotifyHotKeys: Spotify still running, close loop #%A_Index%...
			}
			else
			{
				OutputDebug, SpotifyHotKeys: Spotify closed
				return
			}
			Sleep %LoopWait%
		}
		OutputDebug, SpotifyHotKeys: Spotify could not be closed in %LoopTimeout% seconds
	}
	else
	{
		OutputDebug, SpotifyHotKeys: Spotify is currently not running, no need to close
	}
	DetectHiddenWindows, Off
	return
}
