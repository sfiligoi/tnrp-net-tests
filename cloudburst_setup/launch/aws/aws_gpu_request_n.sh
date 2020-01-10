#!/bin/bash

if [ $# -ne 1 ]; then
  echo "ERROR: Usage: aws_gpu_request_n.sh <i_per_grp>"
  exit 1
fi

capacity=$1

tmpl=""

for r in ap-southeast-1 eu-central-1 ap-northeast-1 ap-southeast-2; do
  tmpl="${tmpl} ${r}_gpu_g4,${r}"
done

for r in ap-southeast-1 eu-central-1 ap-northeast-1 ap-southeast-2; do
  tmpl="${tmpl} ${r}_gpu_p3,${r}"
done

for r in ap-southeast-1 eu-central-1 ap-northeast-1 ap-southeast-2; do
  tmpl="${tmpl} ${r}_gpu_g2,${r}"
done

for r in ap-southeast-1 eu-central-1 ap-northeast-1 ap-southeast-2; do
  tmpl="${tmpl} ${r}_gpu_p2,${r}"
done

for r in eu-central-1 ap-northeast-1 ap-southeast-2 ap-southeast-1; do
  tmpl="${tmpl} ${r}_gpu_g3,${r}"
done

now=`date +%s`
mkdir -p /tmp/afrg0_${now}
cd /tmp/afrg0_${now}
echo Logs in /tmp/afrg0_${now}

sedmattchstr='TargetCapacity":'

for n in ${tmpl}; do
   t=`echo $n | awk '{split($1,a,","); print a[1]}'`
   zn=`echo $n | awk '{split($1,a,","); print a[2]}'`

   cat /opt/aws_cmds/templates/${t}.json | sed "s/${sedmattchstr} 2,/${sedmattchstr} ${capacity},/" > ${t}.json
   echo "aws ec2 request-spot-fleet --region ${zn} --spot-fleet-request-config file://$PWD/${t}.json # capacity=${capacity}"
   aws ec2 request-spot-fleet --region ${zn} --spot-fleet-request-config file://$PWD/${t}.json > ${t}.id &
   sleep 1
done
echo "Waiting"
wait