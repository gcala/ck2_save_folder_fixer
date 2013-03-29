Crusader Kings II Save Folder Fixer for Linux
=============================================

Version 0.1

Requirements: Crusader Kings II, version 1.092 (Steam version tested)

DISCLAIMER: I'M NOT RESPONSIBLE FOR ANY VIOLATIONS THIS SCRIPT DOES TO PARADOX' EULA.

As any linux gamer know, the game uses a Windows-style save folder:
~/Documents/Paradox Interactive/...

This arise two kind of problems:

 - it not respect XDG Base Directory Specification:
   http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html

 - in case of not-english localized desktops your home contains two Documents
   folders: english and localized version. Not so good.

Recent patch 1.092 from Paradox didn't fix this issue.

This scripts rewrites 9 bytes in ck2 so the game uses a more acceptable
~/.config/Paradox Interactive

After applying the fix move your saved games to the new location,
for example:

$ cd ~

$ mv Documents/Paradox\ Interactive .config/Paradox\ Interactive