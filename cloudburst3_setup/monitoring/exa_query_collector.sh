#!/bin/bash

now=`date +%s`
echo "# Timestamp Count   Fresh Actv Prov Sink   Region    CPUs GPUs Mbps TFLOP32s GPUType"

condor_status -const 'GPUs>0' -af ${now} \
              -af '((CurrentTime-LastHeardFrom)<700)' -af Activity -af CLOUD_Provider -af 'ifthenelse(UCSD_Accessible=?=true,"UCSD","UWMadison")' -af CLOUD_Region -af CPUS -af GPUs \
              -af 'ifthenelse(GPUs>0,CUDADeviceName,undefined)' |sort | uniq -c | \
    awk ' { t = $1; $1 = $2; $2 = t; print; } ' | \
    ./add_flops.py

