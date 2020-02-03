#!/bin/bash

igs=""

for z in a b c f; do
    igs="$igs ig-us-central1-${z}-v100-v8-i2"
done

for z in a b c; do
    igs="$igs ig-europe-west4-${z}-v100-v8-i2"    
done

for z in a b; do
    igs="$igs ig-us-west1-${z}-v100-v8-i2"
done

for z in c; do
    igs="$igs ig-asia-east1-${z}-v100-v8-i2"
done

for ig in $igs; do
   echo ./gcp_set_ig_N.sh ${ig} $1"    
   ./gcp_set_ig_N.sh "${ig}" "$1" 
done

