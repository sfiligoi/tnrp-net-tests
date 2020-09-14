#!/bin/bash

if [ ! -f "/dev/shm/condor_public_ip.config" ]; then
  myip=`curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/network/interface/0/ipv4/ipAddress/0/publicIpAddress?api-version=2017-08-01&format=text"`
  if [ "x$myip" == "x" -o "x${myip:0:3}" == "x10." -o "x$myip" == "x127.0.0.1" ]; then
    # still showing private ip
    sleep 5
    myip=`curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/network/interface/0/ipv4/ipAddress/0/publicIpAddress?api-version=2017-08-01&format=text"`
  fi
  if [ "x$myip" == "x" -o "x${myip:0:3}" == "x10." -o "x$myip" == "x127.0.0.1" ]; then
    # still showing private ip
    sleep 30
    myip=`curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/network/interface/0/ipv4/ipAddress/0/publicIpAddress?api-version=2017-08-01&format=text"`
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
  vmname=`curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/compute/name?api-version=2017-12-01&format=text"`
  if [ $? -eq 0 ]; then
    echo "AZURE_VM_NAME = \"${vmname}\"" >> ${fname}
    echo 'STARTD_EXPRS = $(STARTD_EXPRS) AZURE_VM_NAME' >> ${fname}
  fi
  itype=`curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/compute/vmSize?api-version=2017-08-01&format=text"`
  if [ $? -eq 0 ]; then
    echo "AZURE_TYPE = \"${itype}\"" >> ${fname}
    echo 'STARTD_EXPRS = $(STARTD_EXPRS) AZURE_TYPE' >> ${fname}
  fi
  ssname=`curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/compute/vmScaleSetName?api-version=2017-12-01&format=text"`
  if [ $? -eq 0 ]; then
    if [ "x${ssname}" != "x" ]; then
      ssid=`echo "$vmname" | grep "^${ssname}_" | awk '{split($0,a,"_"); print a[2]}'`
      echo "AZURE_SS_NAME = \"${ssname}\"" >> ${fname}
      echo "AZURE_SS_ID = \"${ssid}\"" >> ${fname}
      echo 'STARTD_EXPRS = $(STARTD_EXPRS) AZURE_SS_NAME AZURE_SS_ID' >> ${fname}
    fi
  fi

  mv ${fname} /dev/shm/condor_public_ip.config
  chmod a+r /dev/shm/condor_public_ip.config
fi

cat /dev/shm/condor_public_ip.config
