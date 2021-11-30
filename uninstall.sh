#!/bin/bash

if [[ "$EUID" -ne 0 ]]; then
    echo -e "\x1b[31mThe deletion of \x1b[1meztex\x1b[22m requires root privileges, which you don't have. Try running again with sudo.\x1b[0m"
    exit 1
fi

if [[ ! -d /opt/eztex ]]; then
    echo -e "\x1b[1;31meztex\x1b[22m does not seem to be installed on this system. Aborting...\x1b[0m"
    exit 2
fi
rm -rf /opt/eztex
rm /usr/local/bin/eztex
echo -e "\x1b[32mSuccessfully uninstalled \x1b[1meztex\x1b[22m from your system\x1b[0m"
