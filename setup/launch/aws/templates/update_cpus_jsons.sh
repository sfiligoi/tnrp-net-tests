#!/bin/bash

for r in us-east-1 us-east-2 eu-west-1 eu-central-1 us-west-2 us-west-1 ap-southeast-1 ap-southeast-2 ap-northeast-1; do
  echo $r
  ./update_json.sh cpus $r "$1"
done
