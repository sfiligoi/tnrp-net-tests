#!/bin/bash
nvidia-smi -L
echo "======================================="
lscpu
echo "======================================="
clinfo
echo "======================================="
nvidia-smi
echo "======================================="
if [ "x${CUDA_VISIBLE_DEVICES}" == "x" ]; then
  export CUDA_VISIBLE_DEVICES=${NVIDIA_VISIBLE_DEVICES}
fi
echo "CUDA_VISIBLE_DEVICES = ${CUDA_VISIBLE_DEVICES}"
cd /root
wget -q http://uaf-10.t2.ucsd.edu/~sfiligoi/nrp_tests/icecube.tgz
tar -xzf icecube.tgz 
echo "NRP TEST Try 1"
cd icecube
date
echo "NRP TEST Start: `date +%s`"
time ./loader.sh -s /cvmfs/icecube.opensciencegrid.org/iceprod/master --url https://iceprod2-api.icecube.wisc.edu --cfgfile task.cfg --offline --gzip-logs 
echo "NRP TEST End: `date +%s`"
date
cd ..
rm -fr icecube
tar -xzf icecube.tgz
echo "NRP TEST Try 2"
cd icecube
date
echo "NRP TEST Start: `date +%s`"
time ./loader.sh -s /cvmfs/icecube.opensciencegrid.org/iceprod/master --url https://iceprod2-api.icecube.wisc.edu --cfgfile task.cfg --offline --gzip-logs
echo "NRP TEST End: `date +%s`"
date
cd ..
rm -fr icecube

