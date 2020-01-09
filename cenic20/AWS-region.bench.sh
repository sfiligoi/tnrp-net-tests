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

idrange=`condor_submit -terse "cloud_region=AWS-${r}" submit_stash_us.condor`
rc=$?

# give it 20 minutes to complete
if [ $rc -eq 0 ]; then
  id=`echo "$idrange" | awk '{split($1,a,"."); print a[1]}'`
  echo "AWS-${r} job: $id"
  condor_wait -wait 1200 condor.log "$id"
  rc2=$?
  if [ $rc2 -ne 0 ]; then
    echo "WARNING: Job not completed, removing $id"
    condor_rm "$id"
  fi
fi


#
# Final Cleanup
#

cd $sdir/aws
./cancel_AWS-${r}.spot.sh
rm -f ./cancel_AWS-${r}.spot.sh
exit $rc


