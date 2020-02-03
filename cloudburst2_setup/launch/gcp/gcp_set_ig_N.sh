#!/bin/bash

#
# args: ig N
#

ig=$1
sz=$2

if [ -z "${ig}" ]; then
  echo "ERROR: Need ig"
  exit 1
fi

r=`echo "$ig" | awk '{split($1,a,"-"); print a[2] "-" a[3]}'`

if [ -z "$r" ]; then
  echo "ERROR: Invalid ig ${ig}, could not parse region" 
  exit 1
fi

gcloud compute instance-groups managed resize "${ig}" --region="${r}" --size="$sz" >> /opt/gcp_cmds/tmp/${ig}.log

