#!/bin/bash

if [[ "$EUID" -ne 0 ]]; then
    echo -e "\x1b[31mThe installation of \x1b[1meztex\x1b[22m requires root privileges, which you don't have. Try running again with sudo.\x1b[0m"
    exit 1
fi

if [[ -d /opt/eztex ]]; then
    echo -e "\x1b[1;33meztex\x1b[22m seems to already be installed on your system. Trying to update instead...\x1b[0m"
    cd /opt/eztex || exit 2
    git pull
else
    git clone 'https://github.com/RubixDev/eztex.git' /opt/eztex
fi

if [[ ! -e /usr/local/bin/eztex ]]; then
    ln -s /opt/eztex/eztex.sh /usr/local/bin/eztex
fi
echo -e "\x1b[32mSuccessfully installed \x1b[1meztex\x1b[22m to your system\x1b[0m"
