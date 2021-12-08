# Quest Tools

## Quick Status Change
Changes status in MS Teams. Teams doesn't seem to be perfectly reliable, change *teamsSleep* value (see **Edit Settings** below).

The shortcuts below are editable in the **Settings**. See me for tips on changing these.

+ Ctrl+F1  - *Available*
+ Ctrl+F2  - *Away* (Prompts to lock computer)
+ Ctrl+F3  - *Do Not Disturb* (**NO** notifications in MS Teams)
+ Ctrl+F4  - *Busy*
+ Ctrl+F5  - *Custom 1* (**DND** in Teams)
+ Ctrl+F6  - *Custom 2* (**Away** in Teams)

## Basic Shortcuts
Provides an option to **lock** the numlock on. This means that you *cannot* turn off numlock.

By default, this option is disabled. Follow instructions in **Edit Settings** to set the *numLockOn* value to **1**.

## Window Wizard
Hides and shows different windows. Will always bring focus to the window.

+ F7 - Your Phone
+ F8 - Slack (I've had issues with hiding this, edit Settings file [see below] to set *SlackHide* to **0**)
+ F9 - Teams
+ F10 - Outlook
+ F11 - 8x8 Phone

_Commands for Teams are configured in **Settings**, if Teams changes how it launches, these may need to be updated._

## AppKill
Sometimes killing Teams from the System Tray doesn't work (Teams starts itself again). This kills the process. If you get an warning message that it couldn't kill Teams, run it a second time, that seems to work.

+ Left Ctrl+Left Alt+Numpad 5 - *Kill Teams*

_Hotkeys can be modified using **Edit Settings** below_

## Edit Settings
Click **Settings** in Start Menu>QI Tools and modify affected value.

## SOLIDWORKS Reset - *Not currently implemented*
Kills and restarts SOLIDWORKS. Version that gets started is controlled in INI file (see notes in Quick Status Change above). Change to appropriate shortcut or EXE.

I suggest pinning the icon (benign looking) onto your taskbar.

## 3DConnexion Reset - *Not currently implemented*
Automates running **Stop Driver** followed by **Start Driver**. Will make sure the driver is fully stopped before trying to start it.

**_Please submit issues/comments/suggests using Issues on GitHub_**

\- Xenon
