#!/bin/bash

#
# Arguments:
#  region

r=$1


sdir=$PWD

#
# Phase 1: Provision resources
#

cd azure
rc=$?
if [ $rc -ne 0 ]; then
  exit 1
fi

# now request resources
./AZURE-${r}.spot.sh
rc=$?

if [ $rc -ne 0 ]; then
  exit 1
fi

cd $sdir
rc=$?

if [ $rc -ne 0 ]; then
  echo "ERROR, aborting"
  ./cancel_AZURE-${r}.spot.sh
  exit 1
fi

# give some time for the instance to start up
sleep 30

#
# Phase 2: Submit benchmark
#

cd $sdir/condor
rc=$?
if [ $rc -ne 0 ]; then
  exit 1
fi

#./submit_wait.sh submit_stash_us.condor "AZURE-${r}" 1800
./submit_wait.sh submit_icecube.condor "AZURE-${r}" 1200
rc=$?

#if [ $rc -eq 0 ]; then
#  ./submit_wait.sh submit_stash_I2us.condor "AZURE-${r}" 600
#  rc=$?
#fi

if [ $rc -eq 0 ]; then
  ./submit_wait.sh submit_stash_azureus.condor "AZURE-${r}" 1800
  rc=$?
fi

#
# Phase 3: Request more instances
#


cd $sdir/azure
# note, Azure will increase to 16, not add 16 more
./AZURE-${r}.multi-spot.sh 16
rc=$?
if [ $rc -ne 0 ]; then
  echo "ERROR, aborting"
  ./cancel_AZURE-${r}.spot.sh
  exit 1
fi

# give some time for the instances to initialize
# (the multi-spot script waited for all instances to start
sleep 30

#
# Phase 4: Submit multinode benchmarks
#

cd $sdir/condor
rc=$?
if [ $rc -ne 0 ]; then
  exit 1
fi

./submit_wait.sh submit_icecube.multi.condor "AZURE-${r}" 1800 16
rc=$?


#
# Final Cleanup
#

cd $sdir/azure
./cancel_AZURE-${r}.spot.sh
exit $rc


