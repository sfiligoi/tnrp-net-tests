#!/bin/bash

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

# addons

for n in 2 3 4 5; do
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

