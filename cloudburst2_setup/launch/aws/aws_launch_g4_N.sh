#!/bin/bash

for r in ap-northeast-1 ap-southeast-1 ap-southeast-2 eu-central-1 eu-west-1 us-east-1 us-east-2 us-west-1 us-west-2; do
  echo "/opt/aws_cmds/aws_template_request.sh $r g4 $1"
  /opt/aws_cmds/aws_template_request.sh $r g4 "$1"
done

