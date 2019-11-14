#!/bin/bash

if [ $# -ne 2 ]; then
  echo "ERROR: Usage: igpus_gpu_addon_n.sh <addon> <i_per_grp>"
  exit 1
fi

addon=$1
capacity=$2

igs=""

for n in $addon ; do
 nstr="-i${n}"

  for i in v100 p100 k80; do
   igs="${igs} ig-us-west1-v76-${i}${nstr},us-west1"
  done

  for i in t4 v100 p100 k80; do
   igs="${igs} ig-us-central1-v76-${i}${nstr},us-central1"
  done

  for i in k80 p100; do
   igs="${igs} ig-us-east1-v76-${i}${nstr},us-east1"
  done

  for i in v100 p100 k80; do
   igs="${igs} ig-asia-east1-v76-${i}${nstr},asia-east1"
  done

  for i in p100 k80; do
   igs="${igs} ig-europe-west1-v76-${i}${nstr},europe-west1"
  done

  for i in t4 v100 p100; do
   igs="${igs} ig-europe-west4-v76-${i}${nstr},europe-west4"
  done
done

now=`date +%s`
mkdir -p /tmp/gigna_${now}
cd /tmp/gigna_${now}
echo Logs in /tmp/gigna_${now}
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

