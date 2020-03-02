#!/bin/bash

now=`date +%s`
echo "# Timestamp Count   Fresh Actv Prov GEO    Region    DataRegion  CPUs GPUs TFLOP32s GPUType"

condor_status -af ${now} \
              -af '((CurrentTime-LastHeardFrom)<700)' -af Activity -af CLOUD_Provider -af GEO_Region -af CLOUD_Region -af CLOUD_DataRegion -af CPUS -af GPUs \
              -af 'ifthenelse(GPUs>0,CUDADeviceName,undefined)' |sort | uniq -c | \
    awk ' { t = $1; $1 = $2; $2 = t; print; } ' | \
    /opt/exa_monitor/add_flops.py

(for chost in glidein-simprod.icecube.wisc.edu glidein2.chtc.wisc.edu; do
  condor_status -pool ${chost} -af ${now} \
              -af '((CurrentTime-LastHeardFrom)<700)' -af Activity -af '"OSG"' -af '"OSG"' -af GLIDEIN_Site -af GLIDEIN_Site -af CPUS -af GPUs \
              -af 'ifthenelse(GPUs>0,ifthenelse(CUDADeviceName=?=undefined,GPU_NAMES,CUDADeviceName),undefined)' \
              -const '(GPUs>0)&&(substr(GlobalJobId,0,9)=?="schedd-c9")'
done) | \
    sort | uniq -c | \
    awk ' { t = $1; $1 = $2; $2 = t; print; } ' | \
    /opt/exa_monitor/add_flops.py

