#!/bin/bash 

if [ $# -ne 3 ]; then 
   echo "ERROR: missing argumewnts"
   echo "usge: update_json.sh type region imagename"
   exit 1
fi

ftype=$1
region=$2
image=$3

ami=`aws ec2 describe-images --region "${region}" --filters "Name=name,Values=${image}" --query 'Images[*].{ID:ImageId}'`
if [ $? -ne 0 ]; then
  echo "ERROR: Could not find ami"
  exit 2
fi
if [ -z "$ami" ]; then
  echo "ERROR: got empty ami"
  exit 2
fi

snap=`aws ec2 describe-images --region "${region}" --filters "Name=name,Values=${image}" --query 'Images[*].BlockDeviceMappings[*].Ebs.{ID:SnapshotId}'`
if [ $? -ne 0 ]; then
  echo "ERROR: Could not find snap"
  exit 2
fi
if [ -z "$snap" ]; then
  echo "ERROR: got empty snap"
  exit 2
fi

qt='"'
tag='"ImageId"'
sed -i "s/${tag}: ${qt}.*${qt}/${tag}: ${qt}${ami}${qt}/g" ${region}_${ftype}.json
if [ $? -ne 0 ]; then
  echo "ERROR: Failed to update ami"
  exit 3
fi

tag='"SnapshotId"'
sed -i "s/${tag}: ${qt}.*${qt}/${tag}: ${qt}${snap}${qt}/g" ${region}_${ftype}.json
if [ $? -ne 0 ]; then
  echo "ERROR: Failed to update snap"
  exit 3
fi

