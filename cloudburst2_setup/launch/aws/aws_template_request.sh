#!/bin/bash

if [ $# -ne 3 ]; then
  echo "ERROR: Usage: aws_template_request.sh <region> <i_type> <i_per_grp>"
  exit 1
fi

zn=$1
it=$2
capacity=$3

t="${zn}_gpu_${it}"

sedmattchstr='TargetCapacity":'

cat /opt/aws_cmds/templates/${t}.json | sed "s/${sedmattchstr} 2,/${sedmattchstr} ${capacity},/" > /opt/aws_cmds/tmp/${t}-${capacity}.json
#echo "aws ec2 request-spot-fleet --region ${zn} --spot-fleet-request-config file:///opt/aws_cmds/tmp/${t}-${capacity}.json # capacity=${capacity}"
aws ec2 request-spot-fleet --region ${zn} --spot-fleet-request-config file:///opt/aws_cmds/tmp/${t}-${capacity}.json >> /opt/aws_cmds/tmp/${t}.id &
