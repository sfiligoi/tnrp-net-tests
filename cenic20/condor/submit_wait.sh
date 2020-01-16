#!/bin/bash

#
# Arguments:
#   submit_file cloud_region timeout

f=$1
r=$2
t=$3

if [ "x$4" == "x" ]; then
 idrange=`condor_submit -terse "cloud_region=${r}" ${f}`
 rc=$?
else
 idrange=`condor_submit -terse "cloud_region=${r}" "nmax=$4" ${f}`
 rc=$?
fi

# give it ${t} seconds to complete
if [ $rc -eq 0 ]; then
  id=`echo "$idrange" | awk '{split($1,a,"."); print a[1]}'`
  echo "${r} job: $id"
  condor_wait -wait ${t} condor.log "$id"
  rc2=$?
  if [ $rc2 -ne 0 ]; then
    echo "WARNING: Job not completed, removing $id"
    condor_rm "$id"
  fi
fi

exit $rc
