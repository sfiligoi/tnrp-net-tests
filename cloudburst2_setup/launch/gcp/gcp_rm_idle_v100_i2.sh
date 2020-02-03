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

idles=`condor_status -const '(CLOUD_Provider == "Google")&&(SlotId==1)&&(Activity=="Idle")&&((CurrentTime-LastHeardFrom)<301)' -af GCP_VM_NAME `

#echo "$idles"

if [ -z "${idles}" ]; then
  echo  "No idles found"
else
  #echo "helper"
  python gcp_rm_idle_igrps_helper.py "$igs" "$idles"
fi
