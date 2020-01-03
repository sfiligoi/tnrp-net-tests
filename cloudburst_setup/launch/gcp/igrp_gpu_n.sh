#!/bin/bash

if [ $# -ne 1 ]; then
  echo "ERROR: Usage: igpus_gpu_n.sh <i_per_grp>"
  exit 1
fi

capacity=$1

igs=""


for i in v100 p100 k80; do
 igs="${igs} ig-us-west1-v76-${i},us-west1"
done

for i in t4 v100 p100 k80; do
 igs="${igs} ig-us-central1-v76-${i},us-central1"
done

for i in k80 p100; do
 igs="${igs} ig-us-east1-v76-${i},us-east1"
done

for i in v100 p100 k80; do
 igs="${igs} ig-asia-east1-v76-${i},asia-east1"
done

for i in p100 k80; do
 igs="${igs} ig-europe-west1-v76-${i},europe-west1"
done

for i in t4 v100 p100; do
 igs="${igs} ig-europe-west4-v76-${i},europe-west4"
done

# smaller

for i in p4; do
 igs="${igs} ig-us-central1-v76-${i},us-central1"
done

for i in t4; do
 igs="${igs} ig-asia-northeast1-v76-${i},asia-northeast1"
done

for i in t4 p4; do
 igs="${igs} ig-asia-southeast1-v76-${i},asia-southeast1"
done

# no addons

now=`date +%s`
mkdir -p /tmp/gign_${now}
cd /tmp/gign_${now}
echo Logs in /tmp/gign_${now}
for n in ${igs}; do 
  ig=`echo $n | awk '{split($1,a,","); print a[1]}'`
  zn=`echo $n | awk '{split($1,a,","); print a[2]}'`

  echo "gcloud beta compute instance-groups managed resize ${ig} --region=${zn} --size=${capacity}"
  gcloud beta compute instance-groups managed resize ${ig} --region=${zn} --size=${capacity} > ${ig}.log &
  # sleep a bit in between so not to overwhelm the system
  sleep 1
done
echo "Waiting for completion"
wait

