#!/bin/bash 

echo "INFO: `grep CLOUD_REGION $_CONDOR_MACHINE_AD`"

echo "INFO: Setup $1"
echo "INFO: Parallelism $2"

if [ "$1" == "direct" ]; then
  wantwarmup=1
elif [ "$1" == "direct-multi" ]; then
  wantwarmup=0
else
  echo "Unknown setuo $1"
  exit 1
fi

nmax=$2

mkdir -p tmp
cd tmp

if [ "${wantwarmup}" == "1" ]; then

echo "========== Warmup"
date
t1=`date +%s`
time aria2c -q -j 80 -x 16 -i ../icecube_in_list.txt
rc=$?
echo "RC: ${rc}"
t2=`date +%s`
let dt=$t2-$t1
echo "elapsed: ${dt}" 
date
fsize=`ls -l corsika* |awk '{a=a+$5}END{print a}'`
let bps=${fsize}/${dt}/1000000
echo "Downloaded: ${fsize}"
echo "MiBps: ${bps}"
rm -f corsika*

date

if [ $rc -ne 0 ]; then
  # no point in testing if warmup failed
  echo "ERROR during warmup, aborting"
  exit 1
fi

echo "========== Single aria2c"
date

t1=`date +%s`
time aria2c -q -j 80 -x 16 -i ../icecube_in_list.txt
rc=$?
echo "RC: ${rc}"
t2=`date +%s`
let dt=$t2-$t1
echo "elapsed: ${dt}"
date
fsize=`ls -l corsika* |awk '{a=a+$5}END{print a}'`
let bps=${fsize}/${dt}/1000000
echo "Downloaded: ${fsize}"
echo "MiBps: ${bps}"
rm -f corsika*

date

fi 
# end if wanttwarmup

echo "========== Multiple aria2c: ${nmax}"
date

for ((i=0; $i<${nmax}; i=$i+1)); do mkdir -p subdir_$i; done

t1=`date +%s`
for ((i=1; $i<${nmax}; i=$i+1)); do (cd subdir_$i; for ((j=0; $j<6; j=$j+1)); do aria2c -q --log-level=notice -l out.log -j 80 -x 16 -i ../../icecube_in_list.txt; echo "RC: $?"; rm -f corsika* ; done ) & done
i=0
cd subdir_$i
  for ((j=0; $j<6; j=$j+1)); do 
    aria2c -q --log-level=notice -l out.log -j 80 -x 16 -i ../../icecube_in_list.txt; 
    echo "RC: $?"; 
    fsize=`ls -l corsika* |awk '{a=a+$5}END{print a}'`
    rm -f corsika*
  done
cd ..
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


echo "========= ping -c 2 xdm.icecube.wisc.edu"
ping -c 2 xdm.icecube.wisc.edu

echo "========= tracepath xdm.icecube.wisc.edu"
tracepath xdm.icecube.wisc.edu


