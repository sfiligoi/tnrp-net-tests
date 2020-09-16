#!/bin/bash

fname=`mktemp -p /dev/shm/ --suffix=.config crcXXXX`
myregion=`curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/compute/location?api-version=2017-08-01&format=text"`
if [ ! -f /etc/condor/regions/${myregion}_cidr.config ]; then
  # something went wrong, retry
  sleep 5
  myregion=`curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/compute/location?api-version=2017-08-01&format=text"`
fi
if [ ! -f /etc/condor/regions/${myregion}_cidr.config ]; then
  # something went wrong, retry again
  sleep 30
  myregion=`curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/compute/location?api-version=2017-08-01&format=text"`
fi
if [ ! -f /etc/condor/regions/${myregion}_cidr.config ]; then
  # something went wrong, retry again
  sleep 60
  myregion=`curl -s -H Metadata:true "http://169.254.169.254/metadata/instance/compute/location?api-version=2017-08-01&format=text"`
fi
if [ ! -f /etc/condor/regions/${myregion}_cidr.config ]; then
  myregion=invalid
fi
echo "${myregion}" > ${fname}
mv ${fname} /dev/shm/region.config
chmod a+r /dev/shm/region.config


for ip in `hostname -i`; do
  cidr=`/etc/condor/scripts/parse_cidr.sh /etc/condor/regions/${myregion}_cidr.config "$ip"`
  if [ "x$cidr" != "x" ] ; then
    break
  fi
done

if [ "x$cidr" != "x" ] ; then
  chead=`echo "$cidr" |awk '{print $2}'`
  squid=`echo "$cidr" |awk '{print $3}'`

  if [ -f /etc/condor/regions/${myregion}_local.config ]; then
    cp /etc/condor/regions/${myregion}_local.config /dev/shm/my_local.config
    echo "CLOUD_HEAD = ${chead}" >> /dev/shm/my_local.config
  else
    cp /etc/condor/regions/invalid_local.config /dev/shm/my_local.config
  fi

else
  # just put some invalid values, i.e. localhost
  chead=127.0.0.1
  squid=127.0.0.1 
  cp /etc/condor/regions/invalid_local.config /dev/shm/my_local.config
fi

chmod a+r /dev/shm/my_local.config

echo '/cvmfs /etc/auto.cvmfs' > /etc/auto.master.d/cvmfs.autofs

echo 'CVMFS_REPOSITORIES="`echo $((echo oasis.opensciencegrid.org;echo cms.cern.ch;ls /cvmfs)|sort -u)|tr ' ' ,`"' > /etc/cvmfs/default.local
echo 'CVMFS_QUOTA_LIMIT=10000' >> /etc/cvmfs/default.local
echo CVMFS_HTTP_PROXY="${squid}:3128" >> /etc/cvmfs/default.local
chmod a+r /etc/cvmfs/default.local

