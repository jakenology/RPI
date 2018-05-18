#!/bin/bash
## PiHole-Dark Installation Script
## Copyright 2018 Jayke Peters
## Last Modified 17 May 2018
## Version 0.0.0

## FR001 Add support for root user check
## FR002 Add support for connection test

## Set Global Variables
currentscript="$0"

## Set Functions
# Function that is called when the script exits:
function finish {
    echo "Securely shredding ${currentscript}"; shred -u ${currentscript};
}

## FR003 Add support for more functions

## Install PiHole-Dark
# Change Directory
cd /var/www/html

# Download File(s)
wget https://raw.githubusercontent.com/lkd70/PiHole-Dark/master/install.sh

# Give Execute Permissions
chmod +x install.sh

# Perform Installation
./install.sh

# Exit & Self-Destruct
trap finish EXIT

## FR004 Add support for uninstallation option as parameter as well as log and silent(ly) functions