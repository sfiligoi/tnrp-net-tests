#!/bin/bash

#
# Usage:
#   $1 proxy file
#   $2 infile
#   $3 infile size
#   $4 serverurl
#

export X509_USER_PROXY=$1

t1=`echo $(($(date +%s%N)/1000000))`
echo "`date` INFO: Start globus-url-copy file://$PWD/$2  $4"
globus-url-copy file://$PWD/$2  "$4"
rc=$?
t2=`echo $(($(date +%s%N)/1000000))`

if [ $rc -ne 0 ]; then
  echo "ERROR uploading file! (rc=$rc)"
  exit $rc
fi

let dt=t2-t1
echo "SUCCESS: At ${t2} uploaded $3 MB in $dt ms"



