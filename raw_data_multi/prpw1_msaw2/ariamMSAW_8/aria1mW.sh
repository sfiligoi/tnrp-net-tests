#!/bin/bash
hostname
cd /export/shm
mkdir -p "user_${_CONDOR_SLOT}"
cd "user_${_CONDOR_SLOT}"
pwd
let i=$1%10
date
date 1>&2
echo Job $1
echo Fetching https://prpwest2p0.blob.core.windows.net/prp-test/data/1G_$i.dat
rm -f 1G_$i.*
date
date 1>&2
time aria2c -q --async-dns=false --max-tries=32 --retry-wait=1 -j 80 -x 16 https://prpwest2p0.blob.core.windows.net/prp-test/data/1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*
echo "--- Mid run ---"
echo "--- Mid run ---" 1>&2
date
date 1>&2
time aria2c -q --async-dns=false --max-tries=32 --retry-wait=1 -j 80 -x 16 https://prpwest2p0.blob.core.windows.net/prp-test/data/1G.dat
echo "RC $?"
ls -l 1G.dat
rm -f 1G.*
echo "=== Mid run end ==="
echo "=== Mid run end ===" 1>&2
date
date 1>&2
time aria2c -q --async-dns=false --max-tries=32 --retry-wait=1 -j 80 -x 16 https://prpwest2p0.blob.core.windows.net/prp-test/data/1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*
date
date 1>&2

cd /export/shm
rm -fr "user_${_CONDOR_SLOT}"

