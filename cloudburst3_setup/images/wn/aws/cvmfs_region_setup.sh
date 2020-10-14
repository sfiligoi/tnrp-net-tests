#!/bin/bash

#
# Ask the metadata system where I am
#
fname=`mktemp -p /dev/shm/ --suffix=.config crcXXXX`

myname=`curl -s http://169.254.169.254/latest/meta-data/hostname`
myregion=`echo ${myname} | awk '{split($1,a,"."); print a[2]}'`

if [ ! -f /etc/condor/regions/${myregion}_cidr.config ]; then
  myregion=invalid
fi

#
# Save for future use by e.g. HTCondor
#

echo "${myregion}" > ${fname}
mv ${fname} /dev/shm/region.config
chmod a+r /dev/shm/region.config


#
# Find where is the closest CVMFS and related services
#

for ip in `hostname -i`; do
  cidr=`/etc/condor/scripts/parse_cidr.sh /etc/condor/regions/${myregion}_cidr.config "$ip"`
  if [ "x$cidr" != "x" ] ; then
    break
  fi
done

#
# Save cvmfs and HTCondor config files
#

if [ "x$cidr" != "x" ] ; then
  chead=`echo "$cidr" |awk '{print $2}'`
  squid=`echo "$cidr" |awk '{print $3}'`
  peering=`echo "$cidr" |awk '{print $4}'`

  if [ -f /etc/condor/regions/${myregion}_local.config ]; then
    cp /etc/condor/regions/${myregion}_local.config /dev/shm/my_local.config
    echo "CLOUD_HEAD = ${chead}" >> /dev/shm/my_local.config
    echo "${peering}_Accessible = true" >> /dev/shm/my_local.config
    echo "STARTD_EXPRS = \$(STARTD_EXPRS) ${peering}_Accessible" >> /dev/shm/my_local.config

  else
    cp /etc/condor/regions/invalid_local.config /dev/shm/my_local.config
  fi

else
  # just put some invalid values, i.e. localhost
  chead=127.0.0.1
  squid=127.0.0.1 
  peering=none

  cp /etc/condor/regions/invalid_local.config /dev/shm/my_local.config
fi

chmod a+r /dev/shm/my_local.config

echo '/cvmfs /etc/auto.cvmfs' > /etc/auto.master.d/cvmfs.autofs

echo 'CVMFS_REPOSITORIES="`echo $((echo oasis.opensciencegrid.org;echo cms.cern.ch;ls /cvmfs)|sort -u)|tr ' ' ,`"' > /etc/cvmfs/default.local
echo 'CVMFS_QUOTA_LIMIT=10000' >> /etc/cvmfs/default.local
echo CVMFS_HTTP_PROXY="${squid}:3128" >> /etc/cvmfs/default.local
chmod a+r /etc/cvmfs/default.local

