#!/bin/bash

#
# Query ig and set to current size
#

igs=""

#for z in a b f; do
#    igs="$igs ig-us-central1-${z}-t4-v8-i2"
#done


for z in b c; do
    igs="$igs ig-europe-west4-${z}-t4-v8-i2"
done

for z in a c; do
    igs="$igs ig-asia-northeast1-${z}-t4-v8-i2"
done

for z in b c; do
    igs="$igs ig-asia-southeast1-${z}-t4-v8-i2"
done

for ig in $igs; do
   r=`echo $ig | awk '{split($1,a,"-"); print a[2] "-" a[3]}'`

   echo "gcloud compute instance-groups managed describe ${ig} --region=${r} | grep -e none -e '^targetSize'"

   out=`gcloud compute instance-groups managed describe ${ig} --region=${r}`
  
   csize=`echo "$out" |awk '/none/{print $2}'`
   tsize=`echo "$out" |awk '/^targetSize/{print $2}'`

   echo "# ${ig} ${csize}/${tsize}"
   if [ "$csize" != "$tsize" ]; then
     echo "gcloud compute instance-groups managed resize ${ig} --region=${r} --size=${csize}"
     gcloud compute instance-groups managed resize ${ig} --region=${r} --size="${csize}" >> /opt/gcp_cmds/tmp/${ig}.log
   fi
done

