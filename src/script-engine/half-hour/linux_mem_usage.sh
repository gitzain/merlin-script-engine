#!/bin/sh

url=""
what="mem"
tags=",device=router"
timestamp=$(date +%s)

# Get the value we need and store it in the varable value
value=`free -m | awk 'NR==2{print $3*100/$2 }'`

# Prep and send the data to influxdb
payload="$what$tags value=$value $timestamp"
curl -d "$payload" -H "Content-Type: application/octet-stream" "$url"