#!/bin/bash
cd /dev/shm
pwd
i=$1
b=`echo $i | awk '{a=$1%16; printf("%x\n",a)}'`
date
date 1>&2
echo Job $i
echo Uploading 1G.dat to s3://prp-test-us-east1/${b}_test./data/1G_$i.dat

time time aws s3 cp --only-show-errors /dev/shm/1G.dat s3://prp-test-us-east1/${b}_testa/data/1G_$i.dat
echo "--- Mid run ---"
echo "--- Mid run ---" 1>&2
date
date 1>&2
time time aws s3 cp --only-show-errors /dev/shm/1G.dat s3://prp-test-us-east1/${b}_testm/data/1G_$i.dat
echo "=== Mid run end ==="
echo "=== Mid run end ===" 1>&2
date
date 1>&2
time time aws s3 cp --only-show-errors /dev/shm/1G.dat s3://prp-test-us-east1/${b}_testb/data/1G_$i.dat
date
date 1>&2

