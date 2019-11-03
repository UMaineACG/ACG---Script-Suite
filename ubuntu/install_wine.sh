#!/bin/bash
# Install WINE (Windows emulator)    
    sudo dpkg --add-architecture i386
    wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
    sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
    sudo apt-get update
    sudo apt-get install --install-recommends -y -f winehq-stable winetricks 
    winetricks
