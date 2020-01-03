#!/bin/bash
echo "# Timestamp Count   Actv Prov GEO    Region    DataRegion  CPUs GPUs GPUType"

condor_status -af `date +%s` -af Activity -af CLOUD_Provider -af GEO_Region -af CLOUD_Region -af CLOUD_DataRegion -af CPUS -af GPUs -af 'ifthenelse(GPUs>0,CUDADeviceName,undefined)' |sort | uniq -c | \
    awk ' { t = $1; $1 = $2; $2 = t; print; } '
