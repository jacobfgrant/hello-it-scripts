#!/bin/bash

#  Displays OneDrive sync status
#
#  Title: OneDrive sync status
#  Tooltip: Status recommendation
#
#  Status:
#    Green  - OneDrive syncing
#    Orange - OneDrive not syncing
#    Red    - OneDrive not installed
#
#
#  Created by Jacob F. Grant
#
#  Written: 11/13/2017
#  Updated: 12/14/2017

### The following line load the Hello IT bash script lib
. "$HELLO_IT_SCRIPT_SH_LIBRARY/com.github.ygini.hello-it.scriptlib.sh"


function checkOneDriveStatus {
    if [ -d "/Applications/OneDrive.app" ]
    then
        if [ $(ps aux | grep "OneDrive" | wc -l) -gt 1 ]
        then
            updateTitle "OneDrive is ON"
            updateState "${STATE[0]}"
            updateTooltip "OneDrive is syncing your files"
        else
            updateTitle "OneDrive is OFF"
            updateState "${STATE[1]}"
            updateTooltip "Click to open OneDrive and start syncing"
        fi
    else
        updateTitle "OneDrive not installed"
        updateState "${STATE[2]}"
        updateTooltip "Please install the OneDrive app"
    fi
}


function openOneDrive {
    if [ -d "/Applications/OneDrive.app" ]
    then
        open "/Applications/OneDrive.app"
    fi
}


### This function is called when the user click on your item
function onClickAction {
    openOneDrive
    sleep 15s
    checkOneDriveStatus
}

### This function is called when you've set Hello IT to run your script on a regular basis
function fromCronAction {
    checkOneDriveStatus
}

### This function is called when Hello IT need to know the title to display
### Use it to provide dynamic title at load.
function setTitleAction {
    checkOneDriveStatus
}

### The only things to do outside of a bash function is to call the main function defined by the Hello IT bash lib.
main $@

exit 0
