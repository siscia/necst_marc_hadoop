#!/bin/bash

blocksize="$1"
replication="$2"
heartbeat="$3"
idmacchina="$4"
uuid="$5"
master=false

# if the uuid is empty the script invoked is the `master` it will invoke the start up script on all the other nodes

if [[ "$uuid" == "" ]]; then ## check if uuid is empty
    uuid=$(uuidgen)
    master=true
fi

## create the necessary directory in the home in case they don't exists

maindir=$(printf "%s/%s_%s_%s" $HOME $blocksize $replication $heartbeat )

if [ ! -d "$maindir" ]; then
    mkdir -p "$maindir"
fi

cd "$maindir"

localdir=$(printf "%s_%s_%s" $(date +%s) $uuid $idmacchina)

if [ ! -d "$localdir" ]; then
    mkdir -p "$localdir"
fi


cd "$localdir"

### INVOKE SCRIPT IN THE OTHER NODES

function log_statistic {
    ## create the file where append the logs
    memoryfile=$(printf "memory_%s_%s.txt" $uuid $idmacchina)
    diskIOfile=$(printf "diskIO_%s_%s.txt" $uuid $idmacchina)
    networkIOfile=$(printf "networkIO_%s_%s.txt" $uuid $idmacchina)
    touch "$memoryfile"
    touch "$diskIOfile"
    touch "$networkIOfile"

    ## log the statistic

    tcpdump -i wlan0 >> "$networkIOfile"
    iostat -d 1 -t >> "$diskIOfile"
    while true; do
	printf "\n\nTimeStamp:\t%s\n" $(date +%s) >> "$memoryfile"
	cat /proc/meminfo >> "$memoryfile"	
	sleep 1
    done
}


log_statistic

