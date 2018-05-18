#!/bin/bash

## Chronometer 2 Installation Script
## Initial Commit
## Version 0.0.0
## Copyright 2018 Jayke Peters

## Install Chronometer 2
# Change Directory
cd

# Download Chronometer 2
wget -N https://raw.githubusercontent.com/jpmck/chronometer2/master/chronometer2.sh

# Give Execute Permissions
chmod +x chronometer2.sh

# Configure Start Options
# add ./chronometer2.sh to the end of ~/.bashrc

# Configure Sleep Options
# add this to crontab
# PiTFT+ SLEEPY TIME
# Turn off the PiTFT+ at midnight
00 00 * * * sh -c 'echo "0" > /sys/class/backlight/soc\:backlight/brightness'
# Turn on the PiTFT+ at 8:00 am
00 08 * * * sh -c 'echo "1" > /sys/class/backlight/soc\:backlight/brightness'
