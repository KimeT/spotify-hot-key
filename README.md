# Spotify HotKeys

[Spotify](https://www.spotify.com) keyboard shortcuts for keyboards without media buttons or others, where Alt+Arrow-shortcuts are easier to use.

Implemented with [AutoHotKey](https://www.autohotkey.com).

EXE conversions created without compression and with compression with [MPRESS](https://www.matcode.com/mpress.htm) and [UPX](https://upx.github.io) freeware as described in this [AutoHotKey documentation](https://www.autohotkey.com/docs/Scripts.htm#ahk2exe).


## Use

Run converted EXE either before every time you want to use it or add it to your Windows profile Startup folder to start it every time you log into Windows.

You can also run .ahk file for the same purpose but lose tray icon modifications, which EXE has. Requires AutoHotKey to be installed.


### Shortcuts

**Alt+Up**: Open / Maximize / Minimize Spotify

**Alt+Down**: Play / Pause

**Alt+Left**: Previous

**Alt+Right**: Next

## Conversion

Requires [AutoHotKey](https://www.autohotkey.com) installation with wanted compression programs copied into AutoHotkey **Compiler** subfolder, see [compression documentation](https://www.autohotkey.com/docs/Scripts.htm#mpress). However, conversion without compression works without these.

Also, requires **Ahk2Exe.exe** folder to be in PATH environment varialble (default: *C:\Program Files\AutoHotkey\Compiler*).

Run [convert/convert.cmd](convert/convert.cmd), this converts **Spotify HotKeys.ahk** to **SpotifyHotKeys.exe** with and without compression into corresponding subfolders:

- no-compression
- mpress
- upx
