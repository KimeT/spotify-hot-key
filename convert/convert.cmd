:: Convert to exe without compression
Ahk2Exe.exe /in "..\Spotify HotKeys.ahk" /out "no-compression\SpotifyHotKeys.exe" /icon "..\images\Spotify.ico" /compress 0

:: Convert to exe with MPRESS compression
Ahk2Exe.exe /in "..\Spotify HotKeys.ahk" /out "mpress\SpotifyHotKeys.exe" /icon "..\images\Spotify.ico" /compress 1

:: Convert to exe with UPX compression
Ahk2Exe.exe /in "..\Spotify HotKeys.ahk" /out "upx\SpotifyHotKeys.exe" /icon "..\images\Spotify.ico" /compress 2
