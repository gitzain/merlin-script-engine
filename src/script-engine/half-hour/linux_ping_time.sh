#!/bin/sh

url=""
what="ping"
tags=",device=router,destination=google.com"
timestamp=$(date +%s)

# Get the value we need and store it in the varable value
value=`ping -c1 -W1 www.google.com | grep 'seq=' | sed 's/.*time=\([0-9]*\.[0-9]*\).*$/\1/'`

# Prep and send the data to influxdb
payload="$what$tags value=$value $timestamp"
curl -d "$payload" -H "Content-Type: application/octet-stream" "$url"