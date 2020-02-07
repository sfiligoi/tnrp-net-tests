#!/bin/bash

if [ ! -f "/dev/shm/region.config" ]; then
  fname=`mktemp -p /dev/shm --suffix=.config crcXXXX`
  myregion=`curl -s -H 'Metadata-Flavor: Google' http://metadata.google.internal/computeMetadata/v1/instance/zone |awk '{split($0,a,"zones/"); split(a[2],b,"-"); print b[1] "-" b[2]}'`

  echo "${myregion}" > ${fname}
  mv ${fname} /dev/shm/region.config
else
  myregion=`cat /dev/shm/region.config`
fi

if [ ! -f "/dev/shm/condor_public_ip.config" ]; then
  fname=`mktemp -p /dev/shm --suffix=.config cpiXXXX`
  myip=`curl -s -H 'Metadata-Flavor: Google' http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip`
  if [ "x$myip" == "x" -o "x${myip:0:3}" == "x10." -o "x$myip" == "x127.0.0.1" ]; then
    # still showing private ip
    sleep 5
    myip=`curl -s -H 'Metadata-Flavor: Google' http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip`
  fi
  if [ "x$myip" == "x" -o "x${myip:0:3}" == "x10." -o "x$myip" == "x127.0.0.1" ]; then
    # still showing private ip
    sleep 30
    myip=`curl -s -H 'Metadata-Flavor: Google' http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip`
  fi
  echo "TCP_FORWARDING_HOST = ${myip}" > ${fname}

  echo "DEFAULT_DOMAIN_NAME=${myregion}.gcp" >> ${fname}


  echo "CLOUD_NAT_IP = \"${myip}\"" >> ${fname}
  echo "CLOUD_REGION = \"GCP-${myregion}\"" >> ${fname}

  echo "CLOUD_PROVIDER = \"GCP\"" >> ${fname}

  echo 'STARTD_EXPRS = $(STARTD_EXPRS) CLOUD_PROVIDER CLOUD_NAT_IP CLOUD_REGION' >> ${fname}

  # The following are optional

  echo "GCP_REGION = \"${myregion}\"" >> ${fname}
  echo 'STARTD_EXPRS = $(STARTD_EXPRS) GCP_REGION' >> ${fname}

  vmname=`curl -s -H 'Metadata-Flavor: Google' http://metadata.google.internal/computeMetadata/v1/instance/name`
  if [ $? -eq 0 ]; then
    echo "GCP_VM_NAME = \"${vmname}\"" >> ${fname}
    echo 'STARTD_EXPRS = $(STARTD_EXPRS) GCP_VM_NAME' >> ${fname}
  fi
  itype=`curl -s -H 'Metadata-Flavor: Google' http://metadata.google.internal/computeMetadata/v1/instance/machine-type|awk '{split($0,a,"/"); print a[4]}'`
  if [ $? -eq 0 ]; then
    echo "GCP_TYPE = \"${itype}\"" >> ${fname}
    echo 'STARTD_EXPRS = $(STARTD_EXPRS) GCP_TYPE' >> ${fname}
  fi

  mv ${fname} /dev/shm/condor_public_ip.config
fi

cat /dev/shm/condor_public_ip.config

