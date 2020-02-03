# Quest Tools

## Quick Status Change
Changes status in both MS Teams and 3CX Desktop. Teams doesn't seem to be perfectly reliable, change *teamsSleep* value (see **Edit Settings** below).

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

_See below for notes on modifying Settings (INI file)_

## Basic Shortcuts
Provides an option to **lock** the numlock on. This means that you *cannot* turn off numlock. May not be necessary if {numlock} is left as the default click-to-call option.

By default, this option is disabled. Follow instructions in **Edit Settings** to set the *numLockOn* value to **1**.

## Window Wizard
Hides and shows different windows. Will always bring focus to the window.

+ F6 - Outlook
+ F7 - 3CX
+ F8 - Slack (I've had issues with hiding this, edit Settings file [see below] to set *SlackHide* to **0**)
+ F9 - Teams

## Edit Settings
Click **Settings** in Start Menu>QI Tools and modify affected value.

## SOLIDWORKS Reset - *Not currently implemented*
Kills and restarts SOLIDWORKS. Version that gets started is controlled in INI file (see notes in Quick Status Change above). Change to appropriate shortcut or EXE.

I suggest pinning the icon (benign looking) onto your taskbar.

## 3DConnexion Reset - *Not currently implemented*
Automates running **Stop Driver** followed by **Start Driver**. Will make sure the driver is fully stopped before trying to start it.

**_Please submit issues/comments/suggests using Issues on GitHub_**

\- Xenon
