#!/bin/bash

fname=`mktemp -p /etc/exa_cloud/ --suffix=.config crcXXXX`
myregion=`curl -s -H 'Metadata-Flavor: Google' http://metadata.google.internal/computeMetadata/v1/instance/zone |awk '{split($0,a,"zones/"); split(a[2],b,"-"); print b[1] "-" b[2]}'`
echo "${myregion}" > ${fname}
mv ${fname} /etc/exa_cloud/region.config
chmod a+r /etc/exa_cloud/region.config

echo '/cvmfs /etc/auto.cvmfs' > /etc/auto.master.d/cvmfs.autofs

cp /etc/exa_cloud/regions/${myregion}.cvmfs.conf /etc/cvmfs/default.local
chmod a+r /etc/cvmfs/default.local

