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
date
echo "NRP BENCHMARK Start: `date +%s`"
time /cvmfs/icecube.opensciencegrid.org/py3-v4.1.1/icetray-env combo/V01-00-02 /cvmfs/icecube.opensciencegrid.org/py3-v4.1.1/metaprojects/combo/V01-00-02/clsim/resources/scripts/benchmark.py -n 5000
echo "NRP BENCHMARK End: `date +%s`"
date
echo "NRP BENCHMARK Start: `date +%s`"
time /cvmfs/icecube.opensciencegrid.org/py3-v4.1.1/icetray-env combo/V01-00-02 /cvmfs/icecube.opensciencegrid.org/py3-v4.1.1/metaprojects/combo/V01-00-02/clsim/resources/scripts/benchmark.py -n 5000
echo "NRP BENCHMARK End: `date +%s`"
date
