#!/bin/bash

igs="ig-us-west1-n2,us-west1 ig-us-central1-n2,us-central1 ig-us-east1-n2,us-east1 ig-eu-west1-n2,europe-west1 ig-eu-west4-n2,europe-west4 ig-ap-east1-n2,asia-east1 ig-ap-se1-n2,asia-southeast1"

now=`date +%s`
mkdir -p /tmp/gig0_${now}
cd /tmp/gig0_${now}
echo Logs in /tmp/gig0_${now}
for n in ${igs}; do 
  ig=`echo $n | awk '{split($1,a,","); print a[1]}'`
  zn=`echo $n | awk '{split($1,a,","); print a[2]}'`

  echo "gcloud beta compute instance-groups managed resize ${ig} --region=${zn} --size=0"
  gcloud beta compute instance-groups managed resize ${ig} --region=${zn} --size=0 > ${ig}.log &
  # sleep a bit in between so not to overwhelm the system
  sleep 1
done
echo "Waiting for completion"
wait

