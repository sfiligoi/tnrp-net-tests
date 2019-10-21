#!/bin/bash

if [ $# -ne 1 ]; then
  echo "ERROR, usage: list_output <dir>"
  exit 1
fi

# note, we expect the string NOT to terminate with a /
subdir="$1"

endpoint_tmpl=`cat /dev/shm/exa_cloud_storage.conf`
rc=$?
if [ $rc -ne 0 ]; then
  echo "ERROR: Failed to find config file"
  exit 2
fi

CLOUD_Provider=`grep -i CLOUD_Provider ${_CONDOR_MACHINE_AD} | awk '{print $3}'`

if [ "x${CLOUD_Provider:1:3}" == "xAWS" ]; then
  # AWS wants it / terminated
  subdir="${subdir}/"

  for i in 0 1 2 3 4 5 6 7 8 9 a b c d e f; do
    endpoint=`echo "${endpoint_tmpl}" | sed "s/%s/${i}/"`
    s3_endpoint=`echo "$endpoint" |sed 's/.S3.amazonaws.com//' | sed 's/http.*:/s3:/'`

    aws s3 ls "${s3_endpoint}${subdir}" | awk "/^20/{print \"${endpoint}${subdir}\" \$4}"
  done

elif [ "x${CLOUD_Provider:1:3}" == "xAzu" ]; then
  errstr=`azcopy login --identity`
  rc=$?
  if [ $rc -ne 0 ]; then
   echo "$errstr" 1>&2
   exit 3
  fi

  for i in 0 1 2 3 4 5 6 7 8 9 a b c d e f; do
    endpoint=`echo "${endpoint_tmpl}" | sed "s/%s/${i}/"`
    azcopy list "${endpoint}${subdir}" --output-type text | awk "/Content Size:/{split(\$2,a,\";\"); print \"${endpoint}${subdir}/\" a[1]}"
  done

else
  echo "WARNING: Unknown cloud provider ${CLOUD_Provider}" 1>&2
fi

