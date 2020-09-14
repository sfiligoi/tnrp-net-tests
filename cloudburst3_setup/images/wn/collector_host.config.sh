#!/bin/bash

if [ ! -f "/dev/shm/condor_collector.config" ]; then
  fname=`mktemp -p /dev/shm --suffix=.config cpiXXXX`
  pnum=`python -c "import random; print(random.randrange(2010,2029,1));"`
  echo "CONDOR_HOST = \$(CLOUD_HEAD):$pnum" > ${fname}
  mv ${fname} /dev/shm/condor_collector.config
  chmod a+r /dev/shm/condor_collector.config
fi

cat /dev/shm/condor_collector.config
