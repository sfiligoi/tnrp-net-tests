#!/bin/bash

regions="us-east-1 us-east-2 eu-west-1 eu-central-1 us-west-2 us-west-1 ap-southeast-1 ap-southeast-2 ap-northeast-1"

#now=`date +%s`
#mkdir -p /tmp/afrc0_${now}
#cd /tmp/afrc0_${now}
#echo Logs in /tmp/afrc0_${now}

for r in ${regions}; do
  reqs=`aws ec2 describe-spot-fleet-requests --region ${r} --output text |grep SPOTFLEETREQUESTCONFIGS |awk '/active$/{print $4}'`
  if [ ! -z "${reqs}" ]; then
    for id in ${reqs}; do
      echo "aws ec2 cancel-spot-fleet-requests --region ${r} --terminate-instances --spot-fleet-request-ids ${id}"
      aws ec2 cancel-spot-fleet-requests --region ${r} --terminate-instances --spot-fleet-request-ids ${id}
    done
  fi # nothing to do, else
done

