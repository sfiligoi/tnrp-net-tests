#!/bin/bash

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
   echo "./gcp_set_ig_N.sh ${ig} $1" 
   ./gcp_set_ig_N.sh "${ig}" "$1" 
done

