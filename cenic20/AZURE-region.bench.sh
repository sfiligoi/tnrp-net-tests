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

cd condor
rc=$?
if [ $rc -ne 0 ]; then
  exit 1
fi

./submit_wait.sh submit_stash_us.condor "AZURE-${r}" 1200
rc=$?

if [ $rc -eq 0 ]; then
  ./submit_wait.sh submit_stash_I2us.condor "AZURE-${r}" 600
  rc=$?
fi

#if [ $rc -eq 0 ]; then
#  ./submit_wait.sh submit_stash_azureus.condor "AZURE-${r}" 1200
#  rc=$?
#fi


#
# Final Cleanup
#

cd $sdir/azure
./cancel_AZURE-${r}.spot.sh
exit $rc


