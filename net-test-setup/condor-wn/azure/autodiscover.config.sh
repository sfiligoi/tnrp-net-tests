#!/bin/bash

if [ ! -f "/dev/shm/region.config" ]; then
  fname=`mktemp -p /dev/shm --suffix=.config crcXXXX`
  myregion=`curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/compute/location?api-version=2017-08-01&format=text"`
  if [ ! -f /etc/condor/regions/${myregion}_local.config ]; then
    # something went wrong, retry
    sleep 5
    myregion=`curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/compute/location?api-version=2017-08-01&format=text"`
  fi
  if [ ! -f /etc/condor/regions/${myregion}_local.config ]; then
    # something went wrong, retry again
    sleep 30
    myregion=`curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/compute/location?api-version=2017-08-01&format=text"`
  fi
  echo "${myregion}" > ${fname}
  mv ${fname} /dev/shm/region.config
else
  myregion=`cat /dev/shm/region.config`
fi

if [ ! -f "/dev/shm/condor_public_ip.config" ]; then
  fname=`mktemp -p /dev/shm --suffix=.config cpiXXXX`

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

  echo "TCP_FORWARDING_HOST = ${myip}" > ${fname}

  echo "DEFAULT_DOMAIN_NAME=${myregion}.azure" >> ${fname}


  echo "CLOUD_NAT_IP = \"${myip}\"" >> ${fname}
  echo "CLOUD_REGION = \"AZURE-${myregion}\"" >> ${fname}

  echo "CLOUD_PROVIDER = \"AZURE\"" >> ${fname}

  echo 'STARTD_EXPRS = $(STARTD_EXPRS) CLOUD_PROVIDER CLOUD_NAT_IP CLOUD_REGION' >> ${fname}

  # The following are optional

  echo "AZURE_REGION = \"${myregion}\"" >> ${fname}
  echo 'STARTD_EXPRS = $(STARTD_EXPRS) AZURE_REGION' >> ${fname}

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
fi

cat /dev/shm/condor_public_ip.config
