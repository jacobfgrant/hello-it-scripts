#!/bin/bash

#  Display Mac serial number
#
#  Title: Mac serial number
#  On-click: Copy Mac serial number to clipboard
#
#
#  Created by Jacob F. Grant
#
#  Written: 10/17/2017
#  Updated: 12/14/2017
#

### The following line load the Hello IT bash script lib
. "$HELLO_IT_SCRIPT_SH_LIBRARY/com.github.ygini.hello-it.scriptlib.sh"


serialnum=$(system_profiler SPHardwareDataType | grep Serial | awk '{print $4}')


function getSerialNumber {
    updateTitle "Serial Number: $serialnum"
}


### This function is called when the user click on your item
function onClickAction {
    getSerialNumber
    printf "$serialnum" | pbcopy
}

### This function is called when you've set Hello IT to run your script on a regular basis
function fromCronAction {
    getSerialNumber
}

### This function is called when Hello IT need to know the title to display
### Use it to provide dynamic title at load.
function setTitleAction {
    getSerialNumber
}

### The only things to do outside of a bash function is to call the main function defined by the Hello IT bash lib.
main $@

exit 0
