@echo off
setlocal

:: Set current path to script path to make sure command paths work
cd %~dp0

:: Convert to exe without compression
echo on
Ahk2Exe.exe /in "..\Spotify HotKeys.ahk" /out "no-compression\SpotifyHotKeys.exe" /icon "..\images\Spotify.ico" /compress 0
@echo off

:: Convert to exe with MPRESS compression
echo on
Ahk2Exe.exe /in "..\Spotify HotKeys.ahk" /out "mpress\SpotifyHotKeys.exe" /icon "..\images\Spotify.ico" /compress 1
@echo off

:: Convert to exe with UPX compression
echo on
Ahk2Exe.exe /in "..\Spotify HotKeys.ahk" /out "upx\SpotifyHotKeys.exe" /icon "..\images\Spotify.ico" /compress 2
@echo off

endlocal
