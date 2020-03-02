#!/bin/bash

regions="us-east-1 us-east-2 eu-west-1 eu-central-1 us-west-2 us-west-1 ap-southeast-1 ap-southeast-2 ap-northeast-1"

#now=`date +%s`
#mkdir -p /tmp/afrc0_${now}
#cd /tmp/afrc0_${now}
#echo Logs in /tmp/afrc0_${now}

for r in ${regions}; do
  aws ec2 describe-spot-fleet-requests --region ${r} --output text |grep -A3 SPOTFLEETREQUESTCONFIGS | \
   awk 'BEGIN{found=0}/active$/{found=1;id=$4; state=$2; cnt=0}/capacityOptimized/{cnt=$11}/OVERRIDES/{if (found==1) {print substr($2,0,2) " " id " " state " " cnt}; found=0}' |head -1 |
   while read line; do
     echo "${r} ${line}"
   done
done

