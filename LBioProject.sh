#!/bin/sh

# Name: LBioProject.sh
# License: GPL-3.0
# Description: This bash script is the build system tool for LBioProject.

#
# Note: 1. Don't forget to modify the permission of this file by running "chmod 755 LBioProject.sh" or "chmod +x LBioProject.sh"
#       2. Make sure that perl is already installed on the system
#

help () {
    echo "[ LBioProject ]\n";
    echo "[ Available commands ]";
    echo "* 'help' to show this help prompt";
    echo "* 'test' to perform testing";
    echo "* 'run' to run the project";
    echo "* 'clean' to clean the project\n";
}

if [ $# -gt 0 ]; then
    if [ $1 = "help" ]; then
        help
        exit 0
    elif [ $1 = "run" ]; then
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
    help
    exit 1
fi