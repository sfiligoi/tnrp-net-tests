#!/bin/bash
echo "# Timestamp Count   Fresh Prov GEO    Region    DataRegion  DetectedGPUs GPUType"

condor_status -af `date +%s` -af '((CurrentTime-LastHeardFrom)<301)' -af CLOUD_Provider -af GEO_Region -af CLOUD_Region -af CLOUD_DataRegion -af DetectedGPUs -af 'ifthenelse(GPUs>0,CUDADeviceName,undefined)' -const 'SlotID==1' |sort | uniq -c | \
    awk ' { t = $1; $1 = $2; $2 = t; print; } '
