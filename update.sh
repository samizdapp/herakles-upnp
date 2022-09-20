#!/bin/sh

if [ ! -f ./port ]
then
echo "4000" > /upnp/port
fi


while :
do
    echo "Press [CTRL+C] to stop.."
    PORT=$(cat /upnp/port)
    WAN_ADDR=$(upnpc -l | grep "ExternalIPAddress" | cut -d= -f2 | tr -d ' ')
    LAN_ADDR=$(upnpc -l | grep "Local LAN ip address" | cut -d: -f2)
    echo "try port $PORT"
    while ! upnpc -e "samizdapp" -r 4000 $PORT TCP
    do
        PORT=$(($PORT + 1))
        echo "increment port $PORT"
        echo "$PORT" > /upnp/port
    done


    echo "[\"$WAN_ADDR:$PORT\",\"$LAN_ADDR:4000\"]" > /upnp/addresses
    
    sleep 3600
done
