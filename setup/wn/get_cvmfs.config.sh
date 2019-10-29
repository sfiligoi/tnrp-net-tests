#!/bin/bash

echo 'STARTD_EXPRS = $(STARTD_EXPRS) HAS_CVMFS'

errstr=`/etc/condor/scripts/validate_cvmfs.sh 2>&1`
rc=$?

if [ $rc -ne 0 ]; then
  echo 'HAS_CVMFS=false'
  echo 'START = $(START) && (DEBUG_JOB =?= true)'
  exit 0
fi

teststr=`echo "$errstr" | tail -1`
if [ "x${teststr}" != "xCVMFS OK" ]; then
  echo 'HAS_CVMFS=false'
  echo 'START = $(START) && (DEBUG_JOB =?= true)'
  exit 0
fi

echo 'HAS_CVMFS=true'

