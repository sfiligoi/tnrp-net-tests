#!/bin/bash
cd /dev/shm
mkdir -p "user_${_CONDOR_SLOT}"
cd "user_${_CONDOR_SLOT}"
pwd
let i=$1%400
b=`echo $i | awk '{a=$1%16; printf("%x\n",a)}'`
date
date 1>&2
echo Job $i
echo Fetching https://prp-test-us-east1.S3.amazonaws.com/${b}_testm/data/1G_$i.dat
rm -f 1G_$i.*
date
date 1>&2
time aria2c -q -j 80 -x 16 https://prp-test-us-east1.S3.amazonaws.com/${b}_testm/data/1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*
echo "--- Mid run ---"
echo "--- Mid run ---" 1>&2
date
date 1>&2
time aria2c -q -j 80 -x 16 https://prp-test-us-east1.S3.amazonaws.com/${b}_testm/data/1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*
echo "=== Mid run end ==="
echo "=== Mid run end ===" 1>&2
date
date 1>&2
time aria2c -q -j 80 -x 16 https://prp-test-us-east1.S3.amazonaws.com/${b}_testm/data/1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*
date
date 1>&2

