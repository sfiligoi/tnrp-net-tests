#!/bin/bash
t1=`echo $(($(date +%s%N)/1000000))`
echo "SYNC: At ${t1} started"

./upload_parallel.sh "$1" "$2" 400 'gsiftp://cloudburst-dm-ucsd.icecube.wisc.edu/n%s/test/cloudburst/d%s/' 10 "$3"

t2=`echo $(($(date +%s%N)/1000000))`
echo "SYNC: At ${t2} ended"

