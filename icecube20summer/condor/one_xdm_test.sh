#!/bin/bash
t1=`echo $(($(date +%s%N)/1000000))`
echo "SYNC: At ${t1} started"

./upload_parallel.sh "$1" "$2" 400 gsiftp://xdm.icecube.wisc.edu/mnt/lfs6/admin/vbrik/cloudburst/ 10 "$3"

t2=`echo $(($(date +%s%N)/1000000))`
echo "SYNC: At ${t2} ended"

