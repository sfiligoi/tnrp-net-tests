#!/bin/bash

fname=`mktemp -p /etc/exa_cloud/ --suffix=.config crcXXXX`
myname=`curl -s http://169.254.169.254/latest/meta-data/hostname`
myregion=`echo ${myname} | awk '{split($1,a,"."); print a[2]}'`
echo "${myregion}" > ${fname}
mv ${fname} /etc/exa_cloud/region.config
chmod a+r /etc/exa_cloud/region.config

echo '/cvmfs /etc/auto.cvmfs' > /etc/auto.master.d/cvmfs.autofs

cp /etc/exa_cloud/regions/${myregion}.cvmfs.conf /etc/cvmfs/default.local
chmod a+r /etc/cvmfs/default.local

