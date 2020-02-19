#!/bin/bash 

echo "INFO: `grep CLOUD_REGION $_CONDOR_MACHINE_AD`"

echo "INFO: Setup $1"
echo "INFO: Parallelism $2"

if [ "$1" == "direct" ]; then
  wantwarmup=1
elif [ "$1" == "direct-multi" ]; then
  wantwarmup=0
elif [ "$1" == "chicsquid" ]; then
  wantwarmup=1
  export http_proxy=http://163.253.70.2:50011
  echo "Using squid: 163.253.70.2:50011"
elif [ "$1" == "chicsquid-multi" ]; then
  wantwarmup=0
  export http_proxy=http://163.253.70.2:50011
  echo "Using squid: 163.253.70.2:50011"
else
  echo "Unknown setuo $1"
  exit 1
fi

nmax=$2


mkdir -p tmp
cd tmp

ln -s "../$3" icecube_in_list.base.txt
ln -s "../$4" node_list.txt

cp ../finalize_prpwww.sh .
chmod u+rx finalize_prpwww.sh

if [ "${wantwarmup}" == "1" ]; then

echo "========== Warmup"
./finalize_prpwww.sh icecube_in_list.base.txt node_list.txt >icecube_in_list.txt
date
t1=`date +%s`
time aria2c --max-tries=32 --retry-wait=1 -q -j 80 -x 16 -i icecube_in_list.txt
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
./finalize_prpwww.sh icecube_in_list.base.txt node_list.txt >icecube_in_list.txt
date

t1=`date +%s`
time aria2c --max-tries=32 --retry-wait=1 -q -j 80 -x 16 -i icecube_in_list.txt
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
for ((i=1; $i<${nmax}; i=$i+1)); do (cd subdir_$i; for ((j=0; $j<6; j=$j+1)); do \
   ../finalize_prpwww.sh ../icecube_in_list.base.txt ../node_list.txt >icecube_in_list.txt ;
   aria2c --max-tries=32 --retry-wait=1 -q --log-level=notice -l out.log -j 80 -x 16 -i icecube_in_list.txt; echo "RC: $?"; rm -f corsika* ; done ) & 
done
i=0
cd subdir_$i
  for ((j=0; $j<6; j=$j+1)); do 
    ../finalize_prpwww.sh ../icecube_in_list.base.txt ../node_list.txt >icecube_in_list.txt
    aria2c --max-tries=32 --retry-wait=1 -q --log-level=notice -l out.log -j 80 -x 16 -i icecube_in_list.txt; 
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


echo "========= tracepath k8s-bharadia-01.sdsc.optiputer.net"
tracepath k8s-bharadia-01.sdsc.optiputer.net

echo "========= tracepath ps-100g.sdsu.edu"
tracepath ps-100g.sdsu.edu

echo "========= tracepath siderea.ucsc.edu"
tracepath siderea.ucsc.edu

