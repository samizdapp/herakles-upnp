#!/bin/sh

# if [ ! -f ./port ]
# then
echo "4000" > /upnp/port
# fi


while :
do
	echo "Press [CTRL+C] to stop.."
    PORT=$(cat /upnp/port)
    WAN_ADDR=$(dig +short txt ch whoami.cloudflare @1.0.0.1 | tr -d '"')
    LAN_ADDR=$(upnpc -l | grep "Local LAN ip address" | cut -d: -f2)
    echo "try port $PORT"
    while ! upnpc -r 4000 $PORT TCP
    do
        PORT=$(($PORT + 1))
        echo "increment port $PORT"
        echo $PORT > /upnp/port
    done


    echo "[\"$WAN_ADDR:$PORT\",\"$LAN_ADDR:4000\"]" > /upnp/addresses
    
	sleep 3600
done
