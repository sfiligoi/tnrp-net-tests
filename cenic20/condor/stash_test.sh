#!/bin/bash

echo "INFO: `grep CLOUD_REGION $_CONDOR_MACHINE_AD`"

echo "INFO: Server region $1"
echo "INFO: Parallelism $2"

if [ "$1" == "uswest" ]; then
  url=http://stashcache.t2.ucsd.edu:8000/user/dweitzel/public/chep/file.cvmfs.1000
elif [ "$1" == "useast" ]; then
  url=http://osg.newy32aoa.nrp.internet2.edu:9001/user/dweitzel/public/chep/file.cvmfs.1000
elif [ "$1" == "uscentral" ]; then
  url=http://osg.chic.nrp.internet2.edu:9001/user/dweitzel/public/chep/file.cvmfs.1000
elif [ "$1" == "usmidwest" ]; then
  url=http://osg.kans.nrp.internet2.edu:9001/user/dweitzel/public/chep/file.cvmfs.1000
elif [ "$1" == "awsuswest" ]; then
  url=http://prp-test-us-west2.s3-us-west-2.amazonaws.com/test/data/1G.dat
elif [ "$1" == "awsuseast" ]; then
  url=http://prp-test-us-east1.s3.amazonaws.com/test/data/1G.dat
else
  echo "Unknown region $1"
  exit 1
fi

echo "INFO: URL ${url}"

nmax=$2

mkdir -p tmp
cd tmp

echo "========== Warmup"
date
rm -f out.dat
t1=`date +%s`
time aria2c --header='Want-Digest: ' -q -j 80 -x 16 ${url} -o out.dat
echo "RC: $?"
t2=`date +%s`
let dt=$t2-$t1
echo "elapsed: ${dt}" 
date
ls -l out.dat
md5sum out.dat
fsize=`ls -l out.dat |awk '{print $5}'`
let bps=${fsize}/${dt}/1000000
echo "MiBps: ${bps}"
date

echo "========== Single curl"
date
rm -f out.dat
t1=`date +%s`
time curl -s -o out.dat ${url}
echo "RC: $?"
t2=`date +%s`
let dt=$t2-$t1
echo "elapsed: ${dt}"
date
ls -l out.dat
md5sum out.dat
fsize=`ls -l out.dat |awk '{print $5}'`
let bps=${fsize}/${dt}/1000000
echo "MiBps: ${bps}"
date


echo "========== Single aria2c"
date

rm -f out.dat
t1=`date +%s`
time aria2c --header='Want-Digest: ' -q -j 80 -x 16 ${url} -o out.dat
echo "RC: $?"
t2=`date +%s`
let dt=$t2-$t1
echo "elaped: ${dt}"
ls -l out.dat
md5sum out.dat
fsize=`ls -l out.dat |awk '{print $5}'`
let bps=${fsize}/${dt}/1000000
echo "MiBps: ${bps}"
date
rm -f out.dat

echo "========== Multiple aria2c: ${nmax}"
date

for ((i=0; $i<${nmax}; i=$i+1)); do mkdir -p subdir_$i; done

t1=`date +%s`
for ((i=0; $i<${nmax}; i=$i+1)); do (cd subdir_$i; for ((j=0; $j<6; j=$j+1)); do rm -f out.dat ; aria2c --header='Want-Digest: ' -q --log-level=notice -l out.log -j 80 -x 16 ${url} -o out.dat; echo "RC: $?"; rm -f out.dat ; done ) & done
wait
t2=`date +%s`
let dt=$t2-$t1

echo "elaped: ${dt}"
let bps=6*${nmax}*${fsize}/${dt}/1000000
echo "MiBps: ${bps}"

date
echo "========= Start detailed log ======="
for ((i=0; $i<${nmax}; i=$i+1)); do cat subdir_$i/out.log; done
echo "=========  End detailed log  ======="



