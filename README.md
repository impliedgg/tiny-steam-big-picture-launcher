# tiny steam big picture launcher
110kb (built) shell program to launch explorer and steam in tenfoot (big picture mode).
## usage
### installing
download release msi, double-click to install.
### uninstalling
use [settings > apps](ms-settings:appsfeatures) to locate Tiny Steam Big Picture Mode Launcher, then click the three dots and click uninstall.
### uninstalling v0.1.0
right click [this link](https://github.com/overestimate/tiny-steam-big-picture-launcher/raw/v0.1.0/uninstall.bat), click 'save as...', save the file to your desktop, and run it. it'll clean up the old version. 
## suggestions for usage
if you want a steamos-style login experience, use automatic sign in or a passwordless account.
## building
requires WiX toolset and msvc build tools. build commmands:
```
cl.exe main.c
link.exe main.obj
wix build -i . -src BigPicture.wxs
```
final command is optional, but builds an msi.