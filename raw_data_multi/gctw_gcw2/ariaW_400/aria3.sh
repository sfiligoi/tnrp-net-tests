#!/bin/bash

org_pwd=`pwd`
cd /dev/shm
mkdir -p "user_${_CONDOR_SLOT}"
cd "user_${_CONDOR_SLOT}"
mv ${org_pwd}/my_bins.tgz .
tar -xzf my_bins.tgz
pwd
let i=$1/3
b=`echo $i | awk '{a=$1%16; printf("%x\n",a)}'`
let m=$1%3
if [ $m -eq 0 ]; then
  mc=m
elif [ $m -eq 1 ]; then
  mc=a
else
  mc=b
fi

date
date 1>&2
echo Job $i
echo Fetching 1G.dat from /base_${b}/test./data/1G_$i.dat
rm -f 1G_$i.*dat
date
date 1>&2
time ./my_download /base_${b}/test${mc}/data/1G_$i.dat 1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
echo "--- Mid run ---"
echo "--- Mid run ---" 1>&2
date
date 1>&2
time ./my_download /base_${b}/test${mc}/data/1G_$i.dat 1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
echo "=== Mid run end ==="
echo "=== Mid run end ===" 1>&2
date
date 1>&2
time ./my_download /base_${b}/test${mc}/data/1G_$i.dat 1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
date
date 1>&2
time ./my_download /base_${b}/test${mc}/data/1G_$i.dat 1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
date
date 1>&2

