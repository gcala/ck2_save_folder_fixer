#!/bin/bash
echo "Crusader Kings II Save Folder Fixer for Linux"
echo "Version 1.092"
echo
echo "Requirements: Crusader Kings II, version 1.092"
echo
echo "DISCLAIMER: I'M NOT RESPONSIBLE FOR ANY VIOLATIONS THIS SCRIPT DOES TO CKII'S EULA."
echo
echo "As any linux CKII know, the game uses a Windows-style save folder:"
echo "~/Documents/Paradox Interactive/..."
echo
echo "This arise two kind of problems:"
echo
echo " - it not respect XDG Base Directory Specification:"
echo "   http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html"
echo
echo " - in case of not-english localized desktops your home contains two Documents"
echo "   folders: english and localized version. Not so good."
echo
echo "Recent patch 1.092 from Paradox didn't fix this issue."
echo
echo "This scripts rewrites 9 bytes in ck2 so the game uses a more acceptable"
echo "~/.config/Paradox Interactive"
echo
echo "After applying the fix move your saved games to the new location,"
echo "for example:"
echo
echo "$ cd ~"
echo "$ mv Documents/Paradox\ Interactive .config/Paradox\ Interactive"
echo

applyFix () {
    file=ck2
    original_sum="e556b1dea2d75bcababc68677126ffe6"

    if [ ! -f $file ]
    then
        echo "=> File $file does NOT exists."
        echo "   Be sure to run this script from within Crusader Kings II installation folder"
        exit 1;
    fi

    current_sum=$(md5sum $file | cut -d' ' -f1)

    if [ "$original_sum" != "$current_sum" ]
    then
        echo "=> Checksum mismatch!!"
        echo "   This script works only with version 1.092 of CKII"
        echo "   Exiting"
        exit 1
    fi

    echo
    echo "=> Checksum veriefied. Fine."
    echo

    if [ -f $file-original ]
    then
        echo "=> Seems that current folder already contains a backup copy (ck2-original) of main executable."
        echo "   Please, fix this and run the script again."
        echo "   Exiting..."
        exit 1;
    fi

    echo "=> Backup original file..."
    echo

    cp ck2 ck2-original

    echo "=> Patching file..."
    echo

    printf "\x2F\x2F\x2E\x63\x6F\x6E\x66\x69\x67" | dd of=$file bs=1 seek=15877753 count=9 conv=notrunc

    echo
    echo "=> Done!"
}

read -p "Do you want to continue and apply the fix? (y/N)?" yn
if [ "$yn" = "y" ]; then
    applyFix
else
    exit
fi
