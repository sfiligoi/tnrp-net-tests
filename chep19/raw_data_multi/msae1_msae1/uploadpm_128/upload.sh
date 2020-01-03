#!/bin/bash
azcopy login --identity
cd /dev/shm
pwd
i=$1
b=`echo $i | awk '{a=$1%16; printf("%x\n",a)}'`
date
date 1>&2
echo Job $i
echo Uploading 1G.dat to https://exaeastp${b}.blob.core.windows.net/exa-east/test./data/1G_$i.dat

time time azcopy cp /dev/shm/1G.dat https://exaeastp${b}.blob.core.windows.net/exa-east/testa/data/1G_$i.dat
echo "RC $?"
echo "--- Mid run ---"
echo "--- Mid run ---" 1>&2
date
date 1>&2
time time azcopy cp /dev/shm/1G.dat https://exaeastp${b}.blob.core.windows.net/exa-east/testm/data/1G_$i.dat
echo "RC $?"
echo "=== Mid run end ==="
echo "=== Mid run end ===" 1>&2
date
date 1>&2
time time azcopy cp /dev/shm/1G.dat https://exaeastp${b}.blob.core.windows.net/exa-east/testb/data/1G_$i.dat
echo "RC $?"
date
date 1>&2

