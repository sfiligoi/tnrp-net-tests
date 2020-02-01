#!/bin/bash

igs=""

for z in a b f; do
    igs="$igs ig-us-central1-${z}-t4-v8"
done


for z in b c; do
    igs="$igs ig-europe-west4-${z}-t4-v8"
done

for z in a c; do
    igs="$igs ig-asia-northeast1-${z}-t4-v8"
done

for z in b c; do
    igs="$igs ig-asia-southeast1-${z}-t4-v8"
done

for ig in $igs; do
   r=`echo $ig | awk '{split($1,a,"-"); print a[2] "-" a[3]}'`
   echo "gcloud compute instance-groups managed resize ${ig} --region=${r} --size=$1"
   gcloud compute instance-groups managed resize ${ig} --region=${r} --size="$1" >> /opt/gcp_cmds/tmp/${ig}.log
done

