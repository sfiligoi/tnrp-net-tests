#!/bin/bash

regions="us-east-1 us-east-2 eu-west-1 eu-central-1 us-west-2 us-west-1 ap-southeast-1 ap-southeast-2 ap-northeast-1"

now=`date +%s`
mkdir -p /tmp/afrc0_${now}
cd /tmp/afrc0_${now}
echo Logs in /tmp/afrc0_${now}

for r in ${regions}; do
   cat /opt/aws_cmds/templates/${r}_cpus.json | sed 's/"TargetCapacity": 2,/"TargetCapacity": 1,/' > ${r}_cpus.json
   echo "aws ec2 request-spot-fleet --region ${r} --spot-fleet-request-config file://$PWD/${r}_cpus.json"
   aws ec2 request-spot-fleet --region ${r} --spot-fleet-request-config file://$PWD/${r}_cpus.json > ${r}_cpus.id &
   sleep 1
done
echo "Waiting"
wait
