#!/bin/bash

#  Display FileVault status
#
#  Title: FileVault status
#  Tooltip: FileVault recommendation
#
#  Status:
#    Green  - ON
#    Orange - OFF
#
#
#  Created by Jacob F. Grant
#
#  Written: 10/17/2017
#  Updated: 10/19/2017
#

### The following line load the Hello IT bash script lib
. "$HELLO_IT_SCRIPT_FOLDER/com.github.ygini.hello-it.scriptlib.sh"


filevaultstatus=$(/usr/bin/fdesetup status)


function filvaultStatus {
    if [ "$filevaultstatus" = "FileVault is On." ]
    then
        updateTitle "FileVault is ON"
        updateState "${STATE[0]}"
        updateTooltip "Your device is encrypted"
    else
        updateTitle "FileVault is OFF"
        updateState "${STATE[1]}"
        updateTooltip "Please encrypt your device"
    fi
}


### This function is called when the user click on your item
function onClickAction {
    filvaultStatus
}

### This function is called when you've set Hello IT to run your script on a regular basis
function fromCronAction {
    filvaultStatus
}

### This function is called when Hello IT need to know the title to display
### Use it to provide dynamic title at load.
function setTitleAction {
    filvaultStatus
}

### The only things to do outside of a bash function is to call the main function defined by the Hello IT bash lib.
main $@

exit 0
