#!/bin/bash
condor_status -const '(SlotId==1)' -af AZURE_SS_NAME -af AZURE_SS_ID | awk '{vs[$1][$2]=1}END{for (d in vs) {a=d; for (e in vs[d]) {a=a " " e}; print a }}'
