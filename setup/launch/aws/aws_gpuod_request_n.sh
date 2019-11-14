#!/bin/bash

if [ $# -ne 1 ]; then
  echo "ERROR: Usage: aws_gpu_request_n.sh <i_per_grp>"
  exit 1
fi

capacity=$1

tmpl=""

for r in us-east-1 us-west-2 us-east-2 us-west-1 eu-west-1; do
  tmpl="${tmpl} ${r}_gpuod_g4,${r}"
done

for r in us-east-1 us-west-2 us-east-2 eu-west-1; do
  tmpl="${tmpl} ${r}_gpuod_p3,${r}"
done

for r in us-east-1 us-west-2 us-west-1 eu-west-1; do
  tmpl="${tmpl} ${r}_gpuod_g2,${r}"
done

for r in us-east-1 us-west-2 us-east-2 eu-west-1; do
  tmpl="${tmpl} ${r}_gpuod_p2,${r}"
done

for r in us-east-1 us-west-2 us-east-2 us-west-1 eu-west-1; do
  tmpl="${tmpl} ${r}_gpuod_g3,${r}"
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
   echo "aws ec2 request-spot-fleet --region ${zn} --spot-fleet-request-config file://$PWD/${t}.json"
   aws ec2 request-spot-fleet --region ${zn} --spot-fleet-request-config file://$PWD/${t}.json > ${t}.id &
   sleep 1
done
echo "Waiting"
wait
