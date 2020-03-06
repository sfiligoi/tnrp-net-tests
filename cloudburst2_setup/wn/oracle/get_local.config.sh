#!/bin/bash

if [ ! -f "/etc/exa_cloud/region.config" ]; then
  # we should never get in here, but just in case
  myregion=`curl curl http://169.254.169.254/opc/v1/instance/canonicalRegionName`
else
  myregion=`cat /etc/exa_cloud/region.config`
fi

if [ ! -f "/dev/shm/my_local.config" ]; then
  if [ -f /etc/condor/regions/${myregion}_local.config ]; then
    cp /etc/condor/regions/${myregion}_local.config /dev/shm/my_local.config

  else
    cp /etc/condor/regions/invalid_local.config /dev/shm/my_local.config
  fi
  chmod a+r /dev/shm/my_local.config
fi


# configure exa_cloud as part of the condor config procedure - will not be used before
if [ ! -f /dev/shm/exa_cloud_storage.conf ]; then
  ln -s /etc/exa_cloud/regions/${myregion}_storage.conf /dev/shm/exa_cloud_storage.conf

  if [ -f /etc/exa_cloud/regions/${myregion}_storage_downloads.conf ]; then
    ln -s /etc/exa_cloud/regions/${myregion}_storage_downloads.conf /dev/shm/exa_cloud_storage_downloads.conf
  fi 
fi

cat /dev/shm/my_local.config

