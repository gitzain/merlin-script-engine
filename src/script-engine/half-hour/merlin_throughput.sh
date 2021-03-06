#!/bin/sh

url=""
what="throughput"
tags=",device=router"
timestamp=$(date +%s)

# Get the value we need and store it in the varable value
maxint=4294967295
dir=`dirname $0`
scriptname=`basename $0`
old="/tmp/$scriptname.data.old"
new="/tmp/$scriptname.data.new"
old_epoch_file="/tmp/$scriptname.epoch.old"

old_epoch=`cat $old_epoch_file`
new_epoch=`date "+%s"`
echo $new_epoch > $old_epoch_file

interval=`expr $new_epoch - $old_epoch` # seconds since last sample

if [ -f $new ]; then
    awk -v old=$old -v interval=$interval -v maxint=$maxint '{
        getline line < old
        split(line, a)
        if( $1 == a[1] ) {
            recv_bytes  = $2 - a[2]
            trans_bytes = $5 - a[5]
            if(recv_bytes < 0) {recv_bytes = recv_bytes + maxint}    # maxint counter rollover
            if(trans_bytes < 0) {trans_bytes = trans_bytes + maxint} # maxint counter rollover
            recv_mbps  = (8 * (recv_bytes) / interval) / 1048576     # mbits per second
            trans_mbps = (8 * (trans_bytes) / interval) / 1048576    # mbits per second
            print $1, recv_mbps, $3 - a[3], $4 - a[4], trans_mbps, $6 - a[6], $7 - a[7]
        }
    }' $new  | while read line; do
		
		#interface recv_mbps recv_errs recv_drop trans_mbps trans_errs trans_drop
		#$1,$2,$4,$5,$10,$12,$13
		interfacey=`echo $line | awk '{print $1}'`
		recv_mbps=`echo $line | awk '{print $2}'`
		trans_mbps=`echo $line | awk '{print $5}'`
		
		interface=",interface=$interfacey"
		type=",type=received"
		value="$recv_mbps"

		# Prep and send the data to influxdb
		payload="$what$tags$interface$type value=$value $timestamp"
		curl -d "$payload" -H "Content-Type: application/octet-stream" "$url"
		
		interface=",interface=$interfacey"
		type=",type=transmitted"
		value="$trans_mbps"
		
		payload="$what$tags$interface$type value=$value $timestamp"
		curl -d "$payload" -H "Content-Type: application/octet-stream" "$url"
		
        sleep 1
    done
    mv $new $old
fi

cat /proc/net/dev | tail +3 | tr ':|' '  ' | awk '{print $1,$2,$4,$5,$10,$12,$13}' > $new