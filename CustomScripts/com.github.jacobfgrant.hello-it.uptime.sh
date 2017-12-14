#!/bin/bash

#  Display computer uptime status (time since last reboot)
#
#  Title: Uptime status (days since last reboot)
#  Tooltip: Restart recommendation
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
#  Defaults:
#    alertnumber    =  14
#    warningnumber  =  7
#
#
#  Created by Jacob F. Grant
#
#  Written: 10/17/2017
#  Updated: 12/14/2017

### The following line load the Hello IT bash script lib
. "$HELLO_IT_SCRIPT_SH_LIBRARY/com.github.ygini.hello-it.scriptlib.sh"


rebootdate="$(date -r "$(sysctl -n kern.boottime | awk '{print $4}' | sed 's/,//')" "+%+")"
lastboot="$(date -r "$(sysctl -n kern.boottime | awk '{print $4}' | sed 's/,//')" "+%s")"
now="$(date +"%s")"
diff="$(( (now - lastboot) / 86400 ))"

alertnumber=14
warningnumber=7


function handleOptions {
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


function uptimeStatus {
    if [[ $diff -lt $warningnumber ]] # Diff < Warning
    then
        updateTitle "Time since last reboot: $diff day(s)."
        updateState "${STATE[0]}"
        updateTooltip '"Hello, IT. Have you tried turning it off and on again?"'
    elif [[ $diff -gt $alertnumber ]] # Diff > Alert
    then
        updateTitle "Time since last reboot: $diff day(s)."
        updateState "${STATE[2]}"
        updateTooltip "Consider restarting your computer sometime soon"
    else # Warning <= Diff < Alert
        updateTitle "Time since last reboot: $diff day(s)."
        updateState "${STATE[1]}"
        updateTooltip "Please restart your computer"
    fi
}


### This function is called when the user click on your item
function onClickAction {
    uptimeStatus
}

### This function is called when you've set Hello IT to run your script on a regular basis
function fromCronAction {
    uptimeStatus
}

### This function is called when Hello IT need to know the title to display
### Use it to provide dynamic title at load.
function setTitleAction {
    uptimeStatus
}

### The only things to do outside of a bash function is to call the main function defined by the Hello IT bash lib.
main $@

exit 0
