#!/bin/sh

url=""
what="cpu"
tags=",device=router"
timestamp=$(date +%s)

# Get the value we need and store it in the varable value
value=`top -bn1 | grep ^CPU | tr -d '%' | awk '{print 100 - $8}'`

# Prep and send the data to influxdb
payload="$what$tags value=$value $timestamp"
curl -d "$payload" -H "Content-Type: application/octet-stream" "$url"