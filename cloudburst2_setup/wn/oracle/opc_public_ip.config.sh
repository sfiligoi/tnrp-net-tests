#!/bin/bash

if [ ! -f "/dev/shm/condor_public_ip.config" ]; then
  myip=`curl http://ipecho.net/plain`
  if [ "x$myip" == "x" -o "x${myip:0:3}" == "x10." -o "x$myip" == "x127.0.0.1" ]; then
    # still showing private ip
    sleep 5
    myip=`curl http://ipecho.net/plain`
  fi
  if [ "x$myip" == "x" -o "x${myip:0:3}" == "x10." -o "x$myip" == "x127.0.0.1" ]; then
    # still showing private ip
    sleep 30
    myip=`curl http://ipecho.net/plain`
  fi

  fname=`mktemp -p /dev/shm --suffix=.config cpiXXXX`
  if [ "x$myip" == "x" -o "x${myip:0:3}" == "x10." -o "x$myip" == "x127.0.0.1" ]; then
    # no way this will ever work, just prevent it to be matched
    echo "START = FALSE" > ${fname}
  else
    echo "TCP_FORWARDING_HOST = ${myip}" > ${fname}
    echo "CLOUD_NAT_IP = \"${myip}\"" >> ${fname}
    echo 'STARTD_EXPRS = $(STARTD_EXPRS) CLOUD_NAT_IP' >> ${fname}
  fi

  # The following are optional
  vmname=`curl http://169.254.169.254/opc/v1/instance/hostname`
  if [ $? -eq 0 ]; then
    echo "OPC_VM_NAME = \"${vmname}\"" >> ${fname}
    echo 'STARTD_EXPRS = $(STARTD_EXPRS) OPC_VM_NAME' >> ${fname}
  fi
  itype=`curl http://169.254.169.254/opc/v1/instance/shape`
  if [ $? -eq 0 ]; then
    echo "OPC_TYPE = \"${itype}\"" >> ${fname}
    echo 'STARTD_EXPRS = $(STARTD_EXPRS) OPC_TYPE' >> ${fname}
  fi

  mv ${fname} /dev/shm/condor_public_ip.config
  chmod a+r /dev/shm/condor_public_ip.config
fi

cat /dev/shm/condor_public_ip.config
