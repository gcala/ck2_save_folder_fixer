#!/bin/bash
version=1.111

echo "Crusader Kings II Save Folder Fixer for Linux"
echo "Version $version"
echo
echo "Requirements: Crusader Kings II, version $version"
echo
echo "DISCLAIMER: I'M NOT RESPONSIBLE FOR ANY VIOLATIONS THIS SCRIPT DOES TO CKII'S EULA."
echo
echo "As any linux CKII user know, the game uses a Windows-style save folder:"
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
echo "Recent patch $version from Paradox didn't fix this issue."
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
    original_sum="fc9e0275b8b26e78db8a044045effabc"

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
        echo "   This script works only with version $version of CKII"
        echo "   Exiting"
        exit 1
    fi

    echo
    echo "=> Checksum veriefied. Fine."
    echo

    echo "=> Backing up original file..."
    echo

    cp ck2 ck2-$version

    echo "=> Patching file..."
    echo

    printf "\x2F\x2F\x2E\x63\x6F\x6E\x66\x69\x67" | dd of=$file bs=1 seek=16786001 count=9 conv=notrunc

    echo
    echo "=> Done!"
}

read -p "Do you want to continue and apply the fix? (y/N)?" yn
if [ "$yn" = "y" ]; then
    applyFix
else
    exit
fi
