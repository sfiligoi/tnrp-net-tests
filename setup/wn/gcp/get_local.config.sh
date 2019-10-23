#!/bin/bash

if [ ! -f "/dev/shm/region.config" ]; then
  fname=`mktemp -p /dev/shm --suffix=.config crcXXXX`
  myregion=`curl -s -H 'Metadata-Flavor: Google' http://metadata.google.internal/computeMetadata/v1/instance/zone |awk '{split($0,a,"zones/"); split(a[2],b,"-"); print b[1] "-" b[2]}'`
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
    rm -f /tmp/cvmfs.tar.gz
    mv /dev/shm/cvmfs.tar.gz /tmp/cvmfs.tar.gz
    (cd /dev/shm && tar --no-same-owner -xzvf /tmp/cvmfs.tar.gz) 2>&1 >> /dev/shm/download_cvmfs.log
    rc=$?
    echo "RC=$?" >>/dev/shm/download_cvmfs.log
    date >>/dev/shm/download_cvmfs.log
    rm -f /tmp/cvmfs.tar.gz

    if [ $rc -eq 0 ]; then
      echo 'STARTD_EXPRS = $(STARTD_EXPRS) HAS_CVMFS' >> /dev/shm/my_local.config
      echo 'HAS_CVMFS = true' >> /dev/shm/my_local.config
    fi

  fi
  mv -f /dev/shm/download_cvmfs.log /var/log/download_cvmfs.log
fi

cat /dev/shm/my_local.config

