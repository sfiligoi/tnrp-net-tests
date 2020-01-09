#!/bin/bash

if [ ! -f "/dev/shm/region.config" ]; then
  fname=`mktemp -p /dev/shm --suffix=.config crcXXXX`
  myname=`curl -s http://169.254.169.254/latest/meta-data/hostname`
  myregion=`echo ${myname} | awk '{split($1,a,"."); print a[2]}'`
  if [ "${myregion}" == "ec2" ]; then
    myregion=us-east-1
  fi

  echo "${myregion}" > ${fname}
  mv ${fname} /dev/shm/region.config
else
  myregion=`cat /dev/shm/region.config`
fi

if [ ! -f "/dev/shm/condor_public_ip.config" ]; then
  fname=`mktemp -p /dev/shm --suffix=.config cpiXXXX`
  myip=`curl -s http://169.254.169.254/latest/meta-data/public-ipv4`  
  echo "TCP_FORWARDING_HOST = ${myip}" > ${fname}

  echo "DEFAULT_DOMAIN_NAME=${myregion}.aws" >> ${fname}


  echo "CLOUD_NAT_IP = \"${myip}\"" >> ${fname}
  echo "CLOUD_REGION = \"AWS-${myregion}\"" >> ${fname}

  echo "CLOUD_PROVIDER = \"AWS\"" >> ${fname}

  echo 'STARTD_EXPRS = $(STARTD_EXPRS) CLOUD_PROVIDER CLOUD_NAT_IP CLOUD_REGION' >> ${fname}

  # The following are optional

  echo "AWS_REGION = \"${myregion}\"" >> ${fname}
  echo 'STARTD_EXPRS = $(STARTD_EXPRS) AWS_REGION' >> ${fname}

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
fi

cat /dev/shm/condor_public_ip.config
