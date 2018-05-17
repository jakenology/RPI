#!/bin/bash

# Current Working Directory
#DIRECTORY=`dirname $0`

# Receipt Directory
#RECEIPT_DIR="/var/log"

# Backup Config File
# sudo cp /boot/config.txt /boot/config.txt.backup

# Configure Display Settings
#display_config(){
#RECEIPT="$RECEIPT_DIR""/display_settings"
#if [ ! -f "$RECEIPT" ]; then
    #tee -a /boot/config.txt > /dev/null 2>&1 << END

    ## Custom Settings
    #disable_overscan=1
    #hdmi_force_hotplug=1
    #hdmi_group=1
    #hdmi_mode=1
    #END
#fi
#sudo touch "$RECEIPT"
#}

# Configure Wi-Fi Settings (If eth0 is down)
network_config(){
    wifi_config(){
        echo "wifi config selected"
    }
    ethernet_config(){
        echo "ETHERNET CONFIG SELECTED"
    }
ifconfig | grep -cs '(Ethernet)' > /dev/null 2>&1
if [ $? == 1 ]; then
    wifi_config
else
    ethernet_config
fi
}

# Enable SSH
#enable_ssh(){
    #sudo systemctl enable ssh
#}

network_config
