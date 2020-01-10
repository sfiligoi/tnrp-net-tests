#!/bin/bash

#
# Arguments:
#  region

r=$1


sdir=$PWD

#
# Phase 1: Provision resources
#

cd aws
rc=$?
if [ $rc -ne 0 ]; then
  exit 1
fi

# clean up any remains
if [ -f cancel_AWS-${r}.spot.sh ]; then
  ./cancel_AWS-${r}.spot.sh
  rm -f cancel_AWS-${r}.spot.sh
fi

# now request resources
./AWS-${r}.spot.sh
rc=$?

if [ $rc -ne 0 ]; then
  exit 1
fi

cd $sdir
rc=$?

if [ $rc -ne 0 ]; then
  echo "ERROR, aborting"
  ./cancel_AWS-${r}.spot.sh
  rm -f cancel_AWS-${r}.spot.sh
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

./submit_wait.sh submit_stash_us.condor "AWS-${r}" 1800
rc=$?

if [ $rc -eq 0 ]; then
  ./submit_wait.sh submit_stash_I2us.condor "AWS-${r}" 600
  rc=$?
fi

if [ $rc -eq 0 ]; then
  ./submit_wait.sh submit_stash_awsus.condor "AWS-${r}" 1200
  rc=$?
fi


#
# Final Cleanup
#

cd $sdir/aws
./cancel_AWS-${r}.spot.sh
rm -f ./cancel_AWS-${r}.spot.sh
exit $rc


