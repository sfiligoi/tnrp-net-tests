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

  # also setup any additional machine config

  # IceCube CVMFS
  date >/dev/shm/download_cvmfs.log
  exa_cloud_download_local /setup/cvmfs.tar.gz /dev/shm/cvmfs.tar.gz 2>&1 >>/dev/shm/download_cvmfs.log
  rc=$?
  if [ $rc -eq 0 ]; then
    (cd /dev/shm && tar --no-same-owner -xzvf /dev/shm/cvmfs.tar.gz) 2>&1 >> /dev/shm/download_cvmfs.log
    date >>/dev/shm/download_cvmfs.log
    rm -f /dev/shm/cvmfs.tar.gz

    echo 'STARTD_EXPRS = $(STARTD_EXPRS) HAS_CVMFS' >> /dev/shm/my_local.config
    echo 'HAS_CVMFS = true' >> /dev/shm/my_local.config

  fi
  mv -f /dev/shm/download_cvmfs.log /var/log/download_cvmfs.log
fi

cat /dev/shm/my_local.config

