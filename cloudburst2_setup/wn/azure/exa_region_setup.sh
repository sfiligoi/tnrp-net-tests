#!/bin/bash

fname=`mktemp -p /etc/exa_cloud/ --suffix=.config crcXXXX`
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
if [ ! -f /etc/condor/regions/${myregion}_local.config ]; then
  # something went wrong, retry again
  sleep 60
  myregion=`curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/compute/location?api-version=2017-08-01&format=text"`
fi
echo "${myregion}" > ${fname}
mv ${fname} /etc/exa_cloud/region.config
chmod a+r /etc/exa_cloud/region.config


echo '/cvmfs /etc/auto.cvmfs' > /etc/auto.master.d/cvmfs.autofs

cp /etc/exa_cloud/regions/${myregion}.cvmfs.conf /etc/cvmfs/default.local
chmod a+r /etc/cvmfs/default.local

