#!/bin/bash
cd /dev/shm
pwd
i=`echo ${_CONDOR_SLOT} | awk '{split($0,a,"slot"); print a[2]}'`
echo Slot ${_CONDOR_SLOT}
echo Fetching 1G_$i.dat
rm -f 1G_$i.dat
date
date 1>&2
time aria2c -q -j 80 -x 16 https://prp-test-us-west2.S3.amazonaws.com/test/data/1G_$i.dat
rm -f 1G_$i.dat
echo "--- Mid run ---"
echo "--- Mid run ---" 1>&2
date
date 1>&2
time aria2c -q -j 80 -x 16 https://prp-test-us-west2.S3.amazonaws.com/test/data/1G_$i.dat
rm -f 1G_$i.dat
echo "=== Mid run end ==="
echo "=== Mid run end ===" 1>&2
date
date 1>&2
time aria2c -q -j 80 -x 16 https://prp-test-us-west2.S3.amazonaws.com/test/data/1G_$i.dat
rm -f 1G_$i.dat
date
date 1>&2
time aria2c -q -j 80 -x 16 https://prp-test-us-west2.S3.amazonaws.com/test/data/1G_$i.dat
rm -f 1G_$i.dat
date
date 1>&2
time aria2c -q -j 80 -x 16 https://prp-test-us-west2.S3.amazonaws.com/test/data/1G_$i.dat
rm -f 1G_$i.dat
date
date 1>&2
time aria2c -q -j 80 -x 16 https://prp-test-us-west2.S3.amazonaws.com/test/data/1G_$i.dat
rm -f 1G_$i.dat
date
date 1>&2

