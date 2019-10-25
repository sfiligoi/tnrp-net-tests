#!/bin/bash

if [ $# -ne 1 ]; then
  echo "ERROR: Usage: vmss_cpu_n.sh <i_per_vmss>|t[emplate]"
  exit 1
fi

capacity=$1

if [ "${capacity:0:1}" == "t" ]; then
  istemplate=1
  capacity=VAL
else
  istemplate=0
fi

igs="ig-us-west1-n2,us-west1 ig-us-central1-n2,us-central1 ig-us-east1-n2,us-east1 ig-eu-west1-n2,europe-west1 ig-eu-west4-n2,europe-west4 ig-ap-east1-n2,asia-east1 ig-ap-se1-n2,asia-southeast1"

for i in 1 2; do
 igs="${igs} ig-us-west1-n2i${i},us-west1 ig-us-central1-n2i${i},us-central1 ig-us-east1-n2i${i},us-east1 ig-eu-west1-n2i${i},europe-west1 ig-eu-west4-n2i${i},europe-west4 ig-ap-east1-n2i${i},asia-east1"
done

for i in 3; do
 igs="${igs} ig-us-west1-n2i${i},us-west1 ig-us-central1-n2i${i},us-central1 ig-us-east1-n2i${i},us-east1 ig-eu-west1-n2i${i},europe-west1 ig-eu-west4-n2i${i},europe-west4"
done

for i in 4; do
 igs="${igs} ig-us-west1-n2i${i},us-west1 ig-eu-west1-n2i${i},europe-west1"
done

if [ ${istemplate} -eq 0 ]; then
 now=`date +%s`
 mkdir -p /tmp/gign_${now}
 cd /tmp/gign_${now}
 echo Logs in /tmp/gign_${now}
else
  echo "INFO: Generating template"
fi

for n in ${igs}; do 
  ig=`echo $n | awk '{split($1,a,","); print a[1]}'`
  zn=`echo $n | awk '{split($1,a,","); print a[2]}'`

  echo "gcloud beta compute instance-groups managed resize ${ig} --region=${zn} --size=${capacity}"
  if [ ${istemplate} -eq 0 ]; then
    gcloud beta compute instance-groups managed resize ${ig} --region=${zn} --size=${capacity} > ${ig}.log &
    # sleep a bit in between so not to overwhelm the system
    sleep 1
  fi
done

if [ ${istemplate} -eq 0 ]; then
  echo "Waiting for completion"
  wait
fi

