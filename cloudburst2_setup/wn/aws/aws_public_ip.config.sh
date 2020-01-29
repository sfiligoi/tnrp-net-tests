#!/bin/bash

if [ ! -f "/dev/shm/condor_public_ip.config" ]; then
  fname=`mktemp -p /dev/shm --suffix=.config cpiXXXX`
  myip=`curl -s http://169.254.169.254/latest/meta-data/public-ipv4`  

  echo "TCP_FORWARDING_HOST = ${myip}" > ${fname}
  echo "CLOUD_NAT_IP = \"${myip}\"" >> ${fname}
  echo 'STARTD_EXPRS = $(STARTD_EXPRS) CLOUD_NAT_IP' >> ${fname}

  # The following are optional
  vmname=`curl -s http://169.254.169.254/latest/meta-data/instance-id`
  if [ $? -eq 0 ]; then
    echo "AWS_VM_NAME = \"${vmname}\"" >> ${fname}
    echo 'STARTD_EXPRS = $(STARTD_EXPRS) AWS_VM_NAME' >> ${fname}
  fi
  itype=`curl -s http://169.254.169.254/latest/meta-data/instance-type`
  if [ $? -eq 0 ]; then
    echo "AWS_TYPE = \"${itype}\"" >> ${fname}
    echo 'STARTD_EXPRS = $(STARTD_EXPRS) AWS_TYPE' >> ${fname}
  fi


  mv ${fname} /dev/shm/condor_public_ip.config
  chmod a+r /dev/shm/condor_public_ip.config
fi

cat /dev/shm/condor_public_ip.config
