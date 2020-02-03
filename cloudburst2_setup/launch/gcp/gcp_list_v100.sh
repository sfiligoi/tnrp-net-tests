#!/bin/bash

#
# Query ig and set to current size
#

igs=""

for z in a b c f; do
    igs="$igs ig-us-central1-${z}-v100-v8"
done

for z in a b c; do
    igs="$igs ig-europe-west4-${z}-v100-v8"
done

for z in a b; do
    igs="$igs ig-us-west1-${z}-v100-v8"
done

for z in c; do
    igs="$igs ig-asia-east1-${z}-v100-v8"
done

for ig in $igs; do
   r=`echo $ig | awk '{split($1,a,"-"); print a[2] "-" a[3]}'`

   #echo "gcloud compute instance-groups managed describe ${ig} --region=${r} | grep -e none -e '^targetSize'"

   out=`gcloud compute instance-groups managed describe ${ig} --region=${r}`
  
   csize=`echo "$out" |awk '/none/{print $2}'`
   tsize=`echo "$out" |awk '/^targetSize/{print $2}'`

   echo "${ig} ${csize}/${tsize}"
done

