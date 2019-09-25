# Quest Tools

## Quick Status Change
Changes status in both MS Teams and 3CX Desktop. Teams doesn't seem to be perfectly reliable, seems to be a timing issue. Click **Settings** in Start Menu>QI Tools and increase *teamsSleep* value.

3CX actually dials a number (e.g. **\*30** for *Available*) to change its status. That makes it slow and it "announces" the change over your headset, but it should be almost perfectly reliable.

+ Ctrl+F1  - *Available*
+ Ctrl+F2  - *Away*
+ Ctrl+F3  - *Do Not Disturb* (**NO** notifications in MS Teams)
+ Ctrl+F4  - *Busy* (**DND** in 3CX)
+ Ctrl+F5  - *SB* (**DND** in Teams)
+ Ctrl+F6  - *Lunch* (**Away** in Teams)

## 3CX Click-to-Call
Copies selected text into 3CX. **Must** have text copied to clipboard.

+ NumLock - Dials number on clipboard (must copy number using ctrl+c *before* pressing numlock)
+ F12 - Brings 3CX into focus (does not copy anything)

_See notes in Quick Status Change above for notes on modifying the shortcuts (INI file)_

## Basic Shortcuts
Provides an option to **lock** the numlock on. This means that you *cannot* turn off numlock. May not be necessary if {numlock} is left as the default click-to-call option.

By default, this option is disabled. Follow instructions in **Quick Status Change** to set the *numLockOn* value to **1**.

## SOLIDWORKS Reset - *Not currently implemented*
Kills and restarts SOLIDWORKS. Version that gets started is controlled in INI file (see notes in Quick Status Change above). Change to appropriate shortcut or EXE.

I suggest pinning the icon (benign looking) onto your taskbar.

## 3DConnexion Reset - *Not currently implemented*
Automates running **Stop Driver** followed by **Start Driver**. Will make sure the driver is fully stopped before trying to start it.

## Window Switching Script - *Not currently implemented*
Quick switching to commonly open windows

+ Ctrl+Shift+F1  - Chrome (open new instance if not running)
+ Ctrl+Shift+F2  - Remote Desktop (must include "gm rdp" in title bar)
+ Ctrl+Shift+F3  - Outlook
+ Ctrl+Shift+F4  - slack
+ Ctrl+Shift+F5  - Firefox
+ Ctrl+Shift+F6  - GoToMeeting
+ Ctrl+Shift+F7  - Chrome
+ Ctrl+Shift+F8  - SOLIDWORKS
+ Ctrl+Shift+F9  - 3CX
+ Ctrl+Shift+F10 - Teams

On my keyboard, I have those programmed to (in order):
+ fn+h
+ fn+g
+ fn+o
+ fn+s
+ fn+f
+ fn+m
+ fn+c
+ fn+w
+ fn+x
+ fn+t

**_Please submit issues/comments/suggests using Issues on GitHub_**

\- Xenon
