#!/bin/bash

#  Display Firewall status
#
#  Title: Firewall status
#  Tooltip: Firewall recommendation
#
#  Status:
#    Green  - ON
#    Orange - OFF
#
#
#  Created by Jacob F. Grant
#
#  Written: 10/17/2017
#  Updated: 12/14/2017
#

### The following line load the Hello IT bash script lib
. "$HELLO_IT_SCRIPT_SH_LIBRARY/com.github.ygini.hello-it.scriptlib.sh"


firewallstate=$(defaults read /Library/Preferences/com.apple.alf | sed -n 's/globalstate = \([0-1]\);/\1/p')


function firewallStatus {
    if [ "$firewallstate" -eq 1 ]
    then
        updateTitle "Firewall is ON"
        updateState "${STATE[0]}"
        updateTooltip "Your device is secured"
    else
        updateTitle "Firewall is OFF"
        updateState "${STATE[1]}"
        updateTooltip "Please ensure the firewall is enabled"
    fi
}


### This function is called when the user click on your item
function onClickAction {
    firewallStatus
}

### This function is called when you've set Hello IT to run your script on a regular basis
function fromCronAction {
    firewallStatus
}

### This function is called when Hello IT need to know the title to display
### Use it to provide dynamic title at load.
function setTitleAction {
    firewallStatus
}

### The only things to do outside of a bash function is to call the main function defined by the Hello IT bash lib.
main $@

exit 0
