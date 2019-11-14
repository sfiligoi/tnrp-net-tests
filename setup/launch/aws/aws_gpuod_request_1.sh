#!/bin/bash

#regions="us-east-1 us-east-2 eu-west-1 eu-central-1 us-west-2 us-west-1 ap-southeast-1 ap-southeast-2 ap-northeast-1"
#regions="us-east-1"

tmpl=""

for r in us-east-1 us-west-2 us-east-2; do
  tmpl="${tmpl} ${r}_gpuod_g4,${r}"
done

for r in us-east-1 us-west-2 us-east-2; do
  tmpl="${tmpl} ${r}_gpuod_p3,${r}"
done

for r in us-east-1 us-west-2; do
  tmpl="${tmpl} ${r}_gpuod_g2,${r}"
done

for r in us-east-1 us-west-2 us-east-2; do
  tmpl="${tmpl} ${r}_gpuod_p2,${r}"
done

for r in us-east-1 us-west-2 us-east-2; do
  tmpl="${tmpl} ${r}_gpuod_g3,${r}"
done

now=`date +%s`
mkdir -p /tmp/afrg0_${now}
cd /tmp/afrg0_${now}
echo Logs in /tmp/afrg0_${now}

for n in ${tmpl}; do
   t=`echo $n | awk '{split($1,a,","); print a[1]}'`
   zn=`echo $n | awk '{split($1,a,","); print a[2]}'`

   cat /opt/aws_cmds/templates/${t}.json | sed 's/TargetCapacity": 2,/TargetCapacity": 1,/' > ${t}.json
   echo "aws ec2 request-spot-fleet --region ${zn} --spot-fleet-request-config file://$PWD/${t}.json"
   aws ec2 request-spot-fleet --region ${zn} --spot-fleet-request-config file://$PWD/${t}.json > ${t}.id &
   sleep 1
done
echo "Waiting"
wait
