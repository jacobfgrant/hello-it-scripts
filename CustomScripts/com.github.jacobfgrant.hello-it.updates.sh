#!/bin/bash

#  Display software updates status
#
#  Title: Updates available
#  Tooltip: Updates recommendation
#  On-click: Opens Managed Software Center or App store
#
#  Status:
#    Green  - No updates available
#    Orange - Updates available
#
#
#  Created by Jacob F. Grant
#
#  Written: 10/17/2017
#  Updated: 10/19/2017
#

### The following line load the Hello IT bash script lib
. "$HELLO_IT_SCRIPT_FOLDER/com.github.ygini.hello-it.scriptlib.sh"


function updatesAvailable {
    if [ -f "/Library/Preferences/ManagedInstalls.plist" ]
    then
        updatesCount=$(defaults read /Library/Preferences/ManagedInstalls.plist PendingUpdateCount)
    else
        updatesCount=$(defaults read /Library/Preferences/com.apple.SoftwareUpdate.plist LastRecommendedUpdatesAvailable)
    fi

    if [ "$updatesCount" -eq 0 ]
    then
        #updateTitle "Up To Date"
        updateTitle "No Updates Available"
        updateState "${STATE[0]}"
        updateTooltip "You have no available updates"
    else
        updateTitle "$updatesCount Updates Available"
        updateState "${STATE[1]}"
        updateTooltip "Click to open Managed Software Center and install updates"
    fi
}


function openUpdatesApp {
    if [ -d "/Applications/Managed Software Center.app" ]
    then
        open "/Applications/Managed Software Center.app"
    else
        open "/Applications/App Store.app"
    fi
}


### This function is called when the user click on your item
function onClickAction {
    updatesAvailable
    openUpdatesApp
}

### This function is called when you've set Hello IT to run your script on a regular basis
function fromCronAction {
    updatesAvailable
}

### This function is called when Hello IT need to know the title to display
### Use it to provide dynamic title at load.
function setTitleAction {
    updatesAvailable
}

### The only things to do outside of a bash function is to call the main function defined by the Hello IT bash lib.
main $@

exit 0
