#!/bin/bash

condor_status -const '(CLOUD_Provider == "Azure")&&(SlotId==1)&&(Activity=="Idle")&&((CurrentTime-LastHeardFrom)<301)' -af AZURE_SS_NAME -af AZURE_SS_ID | awk '{vs[$1][$2]=1}END{for (d in vs) {a=d; b="--name " d " --instance-ids "; for (e in vs[d]) {a=a " " e; b=b " " e}; print b}}' | \
while read line; do
  echo "# az vmss deallocate --no-wait --resource-group exa $line"
  az vmss deallocate --no-wait --resource-group exa $line
done

