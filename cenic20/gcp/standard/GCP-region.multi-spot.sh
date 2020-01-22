#!/bin/bash

#
# Arguments:
#   $1 = region
#   $2 = igrp-id
#   $3 = count
#   $4 = deadline
#
# Note: Will wait for all instances to start up

r="$1"
igrp="$2"
cnt="$3"
dl="$4"

gcloud compute instance-groups managed resize ${igrp} --region=${r} --size=${cnt}
rc=$?
if [ $rc -ne 0 ]; then
  echo "Failed"
  exit $rc
fi

# now wait
started=0
for ((i=0; $i<${dl}; i=$i+1)); do
  rcnt=`gcloud compute instance-groups managed list-instances ${igrp} --region=${r} |grep RUNNING |wc -l`  
  echo "${igrp} running ${rcnt}"
  if [ ${rcnt} -eq ${cnt} ]; then
    started=1
    break
  fi
  sleep 1
done;

if [ ${started} -ne 1 ]; then
  echo "Failed"
  gcloud compute instance-groups managed resize ${igrp} --region=${r} --size=0
  exit 1
fi

