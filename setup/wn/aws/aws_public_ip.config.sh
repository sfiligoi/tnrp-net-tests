#!/bin/bash

if [ ! -f "/dev/shm/condor_public_ip.config" ]; then
  fname=`mktemp -p /dev/shm --suffix=.config cpiXXXX`
  echo "TCP_FORWARDING_HOST = `curl -s http://169.254.169.254/latest/meta-data/public-ipv4`" > ${fname}
  mv ${fname} /dev/shm/condor_public_ip.config
fi

cat /dev/shm/condor_public_ip.config
