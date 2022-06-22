#!/bin/sh
while :
do
	echo "Press [CTRL+C] to stop.."
    WAN_ADDR=$(dig +short txt ch whoami.cloudflare @1.0.0.1 | tr -d '"')
    LAN_ADDR=$(upnpc -l | grep "Local LAN ip address" | cut -d: -f2)
    echo "[\"$WAN_ADDR:8889\",\"$LAN_ADDR\"]" > /upnp/addresses
    upnpc -r 4000 4000 TCP
    upnpc -r 4001 4001 TCP
    upnpc -r 80 9090 TCP
	sleep 3600
done
