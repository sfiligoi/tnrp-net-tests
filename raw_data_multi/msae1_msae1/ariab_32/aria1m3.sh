#!/bin/bash
cd /dev/shm
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
echo Fetching http://exaeastb0.blob.core.windows.net/exa-east/${b}_test${mc}/data/1G_$i.dat
rm -f 1G_$i.*dat
date
date 1>&2
time aria2c --retry-wait=1 -q http://exaeastb0.blob.core.windows.net/exa-east/${b}_test${mc}/data/1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
date
date 1>&2
time aria2c --retry-wait=1 -q http://exaeastb0.blob.core.windows.net/exa-east/${b}_test${mc}/data/1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
date
date 1>&2
time aria2c --retry-wait=1 -q http://exaeastb0.blob.core.windows.net/exa-east/${b}_test${mc}/data/1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
echo "--- Mid run ---"
echo "--- Mid run ---" 1>&2
date
date 1>&2
time aria2c --retry-wait=1 -q http://exaeastb0.blob.core.windows.net/exa-east/${b}_test${mc}/data/1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
echo "=== Mid run end ==="
echo "=== Mid run end ===" 1>&2
date
date 1>&2
time aria2c --retry-wait=1 -q http://exaeastb0.blob.core.windows.net/exa-east/${b}_test${mc}/data/1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
date
date 1>&2
time aria2c --retry-wait=1 -q http://exaeastb0.blob.core.windows.net/exa-east/${b}_test${mc}/data/1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
date
date 1>&2

