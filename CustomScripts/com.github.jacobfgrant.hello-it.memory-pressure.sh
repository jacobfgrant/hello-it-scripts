#!/bin/bash

#  Display RAM (memory) usage (memory pressure)
#
#  Title: Percent of memory free
#
#  Status:
#    Green  - X > warningnumber
#    Orange - warningnumber > X > alertnumber
#    Red    - alertnumber > X
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


memPressure=$(memory_pressure | tail -1 | sed 's/System-wide memory free percentage: //'| sed 's/%//')


function handleOptions {
    alertnumber=10
    warningnumber=33

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


function memoryPressure {
    updateTitle "Memory Free: $memPressure%"

    if [[ $memPressure -le "$alertnumber" ]]; then
        updateState "${STATE[2]}"
    elif [[ $memPressure -ge "$warningnumber" ]]; then
        updateState "${STATE[0]}"
    else
        updateState "${STATE[1]}"
    fi
}


### This function is called when the user click on your item
function onClickAction {
    memoryPressure
}

### This function is called when you've set Hello IT to run your script on a regular basis
function fromCronAction {
    memoryPressure
}

### This function is called when Hello IT need to know the title to display
### Use it to provide dynamic title at load.
function setTitleAction {
    memoryPressure
}

### The only things to do outside of a bash function is to call the main function defined by the Hello IT bash lib.
main $@

exit 0
