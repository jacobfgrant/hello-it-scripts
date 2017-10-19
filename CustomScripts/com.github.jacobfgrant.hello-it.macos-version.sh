#!/bin/bash

#  Display Mac OS X/MacOS version and build number
#
#  Title: MacOS version number
#  Tooltip: MacOS build number
#  On-click: Copy MacOS version number to clipboard
#
#
#  Created by Jacob F. Grant
#
#  Written: 10/17/2017
#  Updated: 10/18/2017
#

### The following line load the Hello IT bash script lib
. "$HELLO_IT_SCRIPT_FOLDER/com.github.ygini.hello-it.scriptlib.sh"


osversion="$(sw_vers | grep "ProductVersion" | awk '{print $2}')"
osmajorversion="$(echo $osversion | awk -F. '{print $2}')"
buildversion="$(sw_vers | grep "Build" | awk '{print $2}')"


function macOSVersionBuild {
    if [ $osmajorversion -le 11 ]
    then
        osversionstyle="OS X"
    else
        osversionstyle="MacOS"
    fi
    
    updateTitle "$osversionstyle Version: $osversion"
    updateTooltip "Build: $buildversion"
}


### This function is called when the user click on your item
function onClickAction {
    macOSVersionBuild
    printf "$osversion" | pbcopy
}

### This function is called when you've set Hello IT to run your script on a regular basis
function fromCronAction {
    macOSVersionBuild
}

### This function is called when Hello IT need to know the title to display
### Use it to provide dynamic title at load.
function setTitleAction {
    macOSVersionBuild
}

### The only things to do outside of a bash function is to call the main function defined by the Hello IT bash lib.
main $@

exit 0
