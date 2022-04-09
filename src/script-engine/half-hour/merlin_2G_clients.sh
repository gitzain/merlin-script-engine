#!/bin/sh

url=""
what="clients"
tags=",device=router,interface=wireless_2GHz"
timestamp=$(date +%s)

# Get the value we need and store it in the varable value
value=`wl -i eth1 assoclist | awk '{print $2}' | wc -l`

# Prep and send the data to influxdb
payload="$what$tags value=$value $timestamp"
curl -d "$payload" -H "Content-Type: application/octet-stream" "$url"