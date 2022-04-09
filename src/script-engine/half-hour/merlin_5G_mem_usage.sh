#!/bin/sh

url=""
what="temp"
tags=",device=router_5Ghz"
timestamp=$(date +%s)

# Get the value we need and store it in the varable value
value=`wl -i eth2 phy_tempsense | awk '{ print $1 * .5 + 20 }'`

# Prep and send the data to influxdb
payload="$what$tags value=$value $timestamp"
curl -d "$payload" -H "Content-Type: application/octet-stream" "$url"