#!/bin/bash
condor_status -const '(SlotId==1)&&(Activity=="Idle")&&((CurrentTime-LastHeardFrom)<301)' -af AZURE_SS_NAME -af AZURE_SS_ID | awk '{vs[$1][$2]=1}END{for (d in vs) {a=d; b="az vmss deallocate --no-wait --resource-group exa --name " d " --instance-ids "; for (e in vs[d]) {a=a " " e; b=b " " e}; print "# " a; print b}}'
