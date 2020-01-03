#!/bin/bash

if [ ! -f "/dev/shm/region.config" ]; then
  fname=`mktemp -p /dev/shm --suffix=.config crcXXXX`
  myname=`curl -s http://169.254.169.254/latest/meta-data/hostname`
  myregion=`echo ${myname} | awk '{split($1,a,"."); print a[2]}'`
  echo "${myregion}" > ${fname}
  mv ${fname} /dev/shm/region.config
else
  myregion=`cat /dev/shm/region.config`
fi

if [ ! -f "/dev/shm/my_local.config" ]; then
  if [ -f /etc/condor/regions/${myregion}_local.config ]; then
    cp /etc/condor/regions/${myregion}_local.config /dev/shm/my_local.config

    kgpus=`clinfo -l |grep Device |grep -e 'K80' -e 'K520'`
    if [ "x${kgpus}" != "x" ]; then 
      echo 'CLOUD_DataRegion = strcat("G2",$(CLOUD_DataRegion))' >> /dev/shm/my_local.config
    fi

  else
    cp /etc/condor/regions/invalid_local.config /dev/shm/my_local.config
  fi
fi


# configure exa_cloud as part of the condor config procedure - will not be used before
if [ ! -f /dev/shm/exa_cloud_storage.conf ]; then
  ln -s /etc/exa_cloud/regions/${myregion}_storage.conf /dev/shm/exa_cloud_storage.conf

  if [ -f /etc/exa_cloud/regions/${myregion}_storage_downloads.conf ]; then
    ln -s /etc/exa_cloud/regions/${myregion}_storage_downloads.conf /dev/shm/exa_cloud_storage_downloads.conf
  fi 

  mv -f /dev/shm/download_cvmfs.log /var/log/download_cvmfs.log
fi

cat /dev/shm/my_local.config

