#!/bin/bash

regions="us-east-1 us-east-2 eu-west-1 eu-central-1 us-west-2 ap-southeast-1"

now=`date +%s`
mkdir -p /tmp/afrg1_${now}
cd /tmp/afrg1_${now}
echo Logs in /tmp/afrg1_${now}

for r in ${regions}; do
   cat /opt/aws_cmds/templates/${r}_gpus.json | sed 's/"TargetCapacity": 2,/"TargetCapacity": 1,/' > ${r}_gpus.json
   echo "aws ec2 request-spot-fleet --region ${r} --spot-fleet-request-config file://$PWD/${r}_gpus.json"
   aws ec2 request-spot-fleet --region ${r} --spot-fleet-request-config file://$PWD/${r}_gpus.json > ${r}_gpus.id &
   sleep 1
done
echo "Waiting"
wait
