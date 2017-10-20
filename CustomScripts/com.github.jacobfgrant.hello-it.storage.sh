#!/bin/bash

#  Display storage usage
#
#  Title: Storage used, free, and percent used
#  Tooltip: Storage recommendation
#
#  Status:
#    Green  - X < warningnumber
#    Orange - warningnumber < X < alertnumber
#    Red    - alertnumber < X
#
#
#  Options:
#    -a: Set alertnumber
#    -w: Set warningnumber
#
#
#  Created by Jacob F. Grant
#
#  Written: 10/17/2017
#  Updated: 10/19/2017
#

### The following line load the Hello IT bash script lib
. "$HELLO_IT_SCRIPT_FOLDER/com.github.ygini.hello-it.scriptlib.sh"


storageinfo="$(df -H / | grep "/" | awk '{print $3"B / "$2 "B Used,",$5 " used"}')"
storagetotal="$(df / | grep "/" | awk '{print $2}' | sed 's/G//')"
storageused="$(df / | grep "/" | awk '{print $3}' | sed 's/G//')"
storagepercentused="$(printf "%.0f\n" "$(bc -l <<< "( $storageused / $storagetotal) * 100")")"


function handleOptions {
    alertnumber=90
    warningnumber=70

    while getopts "a:w:" o; do
        case "${o}" in
            a)
                alertnumber=${OPTARG}
                ;;
            w)
                warningnumber=${OPTARG}
                ;;
        esac
    done
}


function storageStatus {
    updateTitle "Storage: $storageinfo"

    if [[ "$storagepercentused" -gt "$alertnumber" ]]
    then
        updateState "${STATE[2]}"
        updateTooltip "You are running dangerously low on storage"
    elif [[ "$storagepercentused" -lt "$warningnumber" ]]
    then
        updateState "${STATE[0]}"
        updateTooltip "You have plenty of storage available"
    else
        updateState "${STATE[1]}"
        updateTooltip "You are beginning to run low on storage"
    fi
}


### This function is called when the user click on your item
function onClickAction {
    storageStatus
}

### This function is called when you've set Hello IT to run your script on a regular basis
function fromCronAction {
    storageStatus
}

### This function is called when Hello IT need to know the title to display
### Use it to provide dynamic title at load.
function setTitleAction {
    storageStatus
}

### The only things to do outside of a bash function is to call the main function defined by the Hello IT bash lib.
main $@

exit 0
