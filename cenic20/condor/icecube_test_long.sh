#!/bin/bash 

echo "INFO: `grep CLOUD_REGION $_CONDOR_MACHINE_AD`"

echo "INFO: Setup $1"
echo "INFO: Parallelism $2"

if [ "$1" == "direct" ]; then
  wantwarmup=1
elif [ "$1" == "direct-multi" ]; then
  wantwarmup=0
else
  echo "Unknown setup $1"
  exit 1
fi

nmax=$2

mkdir -p tmp
cd tmp
mv ../$3 icecube_in_list_long.txt.gz
gunzip icecube_in_list_long.txt.gz


echo "========== Multiple aria2c: ${nmax}"
date

for ((i=0; $i<${nmax}; i=$i+1)); do mkdir -p subdir_$i; done

t1=`date +%s`
for ((i=1; $i<${nmax}; i=$i+1)); do (cd subdir_$i; for ((j=0; $j<6; j=$j+1)); do let l=$RANDOM*11%79500+100; head -${l} ../icecube_in_list_long.txt | tail -24 > my_list.txt; aria2c -q --log-level=notice -l out.log -j 80 -x 16 -i my_list.txt; echo "RC: $?"; ls -l corsika* >> fs.log; rm -f corsika* ; done ) & done
i=0
cd subdir_$i
  for ((j=0; $j<6; j=$j+1)); do 
    let l=$RANDOM*11%79500+100
    head -${l} ../icecube_in_list_long.txt | tail -24 > my_list.txt
    aria2c -q --log-level=notice -l out.log -j 80 -x 16 -i my_list.txt; 
    echo "RC: $?"; 
    ls -l corsika* >> fs.log
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

echo "========= Start file log ======="
for ((i=0; $i<${nmax}; i=$i+1)); do cat subdir_$i/fs.log; done
echo "=========  End detailed log  ======="

echo "========= ping -c 2 xdm.icecube.wisc.edu"
ping -c 2 xdm.icecube.wisc.edu

echo "========= tracepath xdm.icecube.wisc.edu"
tracepath xdm.icecube.wisc.edu

