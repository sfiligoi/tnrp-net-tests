#!/bin/bash
echo "====== env ======"
env
echo "====== env ======"


cd /dev/shm
mkdir -p "user_${_CONDOR_SLOT}"
cd "user_${_CONDOR_SLOT}"
export HOME=`pwd`
pwd
i=$1
b=`echo $i | awk '{a=$1%16; printf("%x\n",a)}'`
date
date 1>&2
echo Job $i
echo Uploading 1G.dat to /base_${b}/test./data/1G_$i.dat

time exa_cloud_upload /dev/shm/1G.dat /base_${b}/testa/data/1G_$i.dat
rc=$?
if [ ${rc} -ne 0 ]; then
  sleep 1
  time exa_cloud_upload /dev/shm/1G.dat /base_${b}/testa/data/1G_$i.dat
  rc=$?
fi
echo "RC ${rc}"
echo "--- Mid run ---"
echo "--- Mid run ---" 1>&2
date
date 1>&2
time exa_cloud_upload /dev/shm/1G.dat /base_${b}/testm/data/1G_$i.dat
rc=$?
if [ ${rc} -ne 0 ]; then
  sleep 1
  time exa_cloud_upload /dev/shm/1G.dat /base_${b}/testm/data/1G_$i.dat
  rc=$?
fi
echo "RC ${rc}"
echo "=== Mid run end ==="
echo "=== Mid run end ===" 1>&2
date
date 1>&2
time exa_cloud_upload /dev/shm/1G.dat /base_${b}/testb/data/1G_$i.dat
rc=$?
if [ ${rc} -ne 0 ]; then
  sleep 1
  time exa_cloud_upload /dev/shm/1G.dat /base_${b}/testb/data/1G_$i.dat
  rc=$?
fi
echo "RC ${rc}"
date
date 1>&2
