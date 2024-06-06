#!/bin/sh

# Name: LBioProject.sh
# License: GPL-3.0
# Description: This bash script is the build system tool for LBioProject.

#
# Note: 1. Don't forget to modify the permission of this file by running "chmod 755 LBioProject.sh" or "chmod +x LBioProject.sh"
#       2. Make sure that perl is already installed on the system
#

if [ $# -gt 0 ]; then
    if [ $1 = "run" ]; then
        perl ./src/main/main.pl
    elif [ $1 = "test" ]; then
        perl ./src/test/test.pl
    elif [ $1 = "clean" ]; then
        if [ -d ./report ]; then
            rm -r ./report/
        fi
    else
        echo "[-] Invalid command: $1"
        exit 0
    fi
else
    echo "help"
    exit 1
fi