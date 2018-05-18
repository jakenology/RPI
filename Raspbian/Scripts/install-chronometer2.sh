#!/bin/bash

## Chronometer 2 Installation Script
## Initial Commit
## Version 0.1.0
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
crontab -l | { cat; echo ""; } | crontab -
crontab -l | { cat; echo "# PiTFT+ SLEEPY TIME"; } | crontab -
crontab -l | { cat; echo "# Turn off the PiTFT+ at midnight"; } | crontab -
crontab -l | { cat; echo "00 00 * * * sh -c 'echo "0" > /sys/class/backlight/soc\:backlight/brightness'"; } | crontab -
crontab -l | { cat; echo "# Turn on the PiTFT+ at 8:00 am"; } | crontab -
crontab -l | { cat; echo "00 08 * * * sh -c 'echo "1" > /sys/class/backlight/soc\:backlight/brightness'"; } | crontab -
