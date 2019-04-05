# Quest Tools

## GMSearch Script
This is a compiled [AutoHotKey](https://autohotkey.com/ "AutoHotKey's Homepage") script that makes it easy to search for a contact in GM.

Simply press CTRL+ALT+= to get a message box asking for the contact's name (same as you would in the search field in the upper left corner of GM). It will then do the search for you and return the results in GM.

Make sure to have GM running or you'll get an error message

## Quick Status Change
Changes status in both MS Teams and 3CX Desktop. Teams doesn't seem to be perfectly reliable, seems to be a timing issue. Find INI file in **%APPDATA%\QI Tools** and increase (and un-comment) *teamsSleep* value.

3CX actually dials a number (e.g. **\*30** for *Available*) to change its status. That makes it slow and it "announces" the change over your headset, but it should be almost perfectly reliable.

+ Ctrl+F1  - *Available*
+ Ctrl+F2  - *Away*
+ Ctrl+F3  - *Do Not Disturb* (**NO** notifications in MS Teams)
+ Ctrl+F4  - *Busy* (**DND** in 3CX)
+ Ctrl+F5  - *Lunch* (**Away** in Teams)
+ Ctrl+F6  - *SB* (**DND** in Teams)

## Window Switching Script
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
