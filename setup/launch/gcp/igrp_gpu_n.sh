#!/bin/bash

if [ $# -ne 1 ]; then
  echo "ERROR: Usage: igpus_gpu_n.sh <i_per_vmss>"
  exit 1
fi

capacity=$1

igs=""
for i in t4 v100 p100 k80; do 
 igs="${igs} ig-us-west1-${i},us-west1"
done
for i in t4 v100 p100 k80 p4; do
 igs="${igs} ig-us-central1-${i},us-central1"
done
for i in k80 t4 p100; do
 igs="${igs} ig-us-east1-${i},us-east1"
done

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

