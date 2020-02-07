#!/bin/bash


myregion=PRP

if [ ! -f "/dev/shm/condor_public_ip.config" ]; then
  fname=`mktemp -p /dev/shm --suffix=.config cpiXXXX`
  echo "DEFAULT_DOMAIN_NAME=prp" >> ${fname}

  # disable multi-port
  echo 'CONDOR_HOST = $(CLOUD_HEAD)' >> ${fname}

  # enable CCB - works well at small scale
  echo 'USE_SHARED_PORT=true' >> ${fname}
  echo 'CCB_ADDRESS = $(COLLECTOR_HOST)' >> ${fname}
  echo 'PRIVATE_NETWORK_NAME = never' >> ${fname}


  echo "CLOUD_REGION = \"PRP\"" >> ${fname}

  echo "CLOUD_PROVIDER = \"PRP\"" >> ${fname}

  echo 'STARTD_EXPRS = $(STARTD_EXPRS) CLOUD_PROVIDER CLOUD_REGION' >> ${fname}

  mv ${fname} /dev/shm/condor_public_ip.config
fi

cat /dev/shm/condor_public_ip.config
