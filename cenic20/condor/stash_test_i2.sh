#!/bin/bash

echo "INFO: `grep CLOUD_REGION $_CONDOR_MACHINE_AD`"


echo "INFO: Servers Internet2 US"
echo "INFO: Parallelism 3x$1"

url1=http://osg.kans.nrp.internet2.edu:9001/user/dweitzel/public/chep/file.cvmfs.1000
url2=http://osg.newy32aoa.nrp.internet2.edu:9001/user/dweitzel/public/chep/file.cvmfs.1000
url3=http://osg.chic.nrp.internet2.edu:9001/user/dweitzel/public/chep/file.cvmfs.1000

echo "INFO: URL1 ${url1}"
echo "INFO: URL2 ${url2}"
echo "INFO: URL3 ${url3}"

nmax=$1

mkdir -p tmp
cd tmp

echo "========== Warmup"
date
rm -f out.dat
t1=`date +%s`
(time aria2c --header='Want-Digest: ' -q -j 80 -x 16 ${url1} -o out1.dat ; echo "RC: $?")&
(time aria2c --header='Want-Digest: ' -q -j 80 -x 16 ${url2} -o out2.dat ; echo "RC: $?")&
(time aria2c --header='Want-Digest: ' -q -j 80 -x 16 ${url3} -o out3.dat ; echo "RC: $?")&
wait
t2=`date +%s`
let dt=$t2-$t1
echo "elapsed: ${dt}" 
date
ls -l out1.dat
md5sum out1.dat
fsize=`ls -l out1.dat |awk '{print $5}'`
let bps=3*${fsize}/${dt}/1000000
echo "MiBps: ${bps}"
date

rm -f out1.dat out2.dat out3.dat

echo "========== Multiple aria2c: 3x${nmax}"
date

for ((i=0; $i<${nmax}; i=$i+1)); do mkdir -p subdir_$i; done

t1=`date +%s`
for ((i=0; $i<${nmax}; i=$i+1)); do 
  (cd subdir_$i; for ((j=0; $j<2; j=$j+1 )); do \
    rm -f out1.dat ; aria2c --header='Want-Digest: ' -q --log-level=notice -l out1.log -j 80 -x 16 ${url1} -o out1.dat; echo "RC: $?"; rm -f out1.dat ; \
    rm -f out1.dat ; aria2c --header='Want-Digest: ' -q --log-level=notice -l out1.log -j 80 -x 16 ${url2} -o out1.dat; echo "RC: $?"; rm -f out1.dat ; \
    rm -f out1.dat ; aria2c --header='Want-Digest: ' -q --log-level=notice -l out1.log -j 80 -x 16 ${url3} -o out1.dat; echo "RC: $?"; rm -f out1.dat ; \
  done ) & 
done
for ((i=0; $i<${nmax}; i=$i+1)); do 
  (cd subdir_$i; for ((j=0; $j<2; j=$j+1 )); do \
    rm -f out2.dat ; aria2c --header='Want-Digest: ' -q --log-level=notice -l out2.log -j 80 -x 16 ${url2} -o out2.dat; echo "RC: $?"; rm -f out2.dat ; \
    rm -f out2.dat ; aria2c --header='Want-Digest: ' -q --log-level=notice -l out2.log -j 80 -x 16 ${url3} -o out2.dat; echo "RC: $?"; rm -f out2.dat ; \
    rm -f out2.dat ; aria2c --header='Want-Digest: ' -q --log-level=notice -l out2.log -j 80 -x 16 ${url1} -o out2.dat; echo "RC: $?"; rm -f out2.dat ; \
   done ) & 
done
for ((i=0; $i<${nmax}; i=$i+1)); do 
  (cd subdir_$i; for ((j=0; $j<2; j=$j+1 )); do \
    rm -f out3.dat ; aria2c --header='Want-Digest: ' -q --log-level=notice -l out3.log -j 80 -x 16 ${url3} -o out3.dat; echo "RC: $?"; rm -f out3.dat ; \
    rm -f out3.dat ; aria2c --header='Want-Digest: ' -q --log-level=notice -l out3.log -j 80 -x 16 ${url1} -o out3.dat; echo "RC: $?"; rm -f out3.dat ; \
    rm -f out3.dat ; aria2c --header='Want-Digest: ' -q --log-level=notice -l out3.log -j 80 -x 16 ${url2} -o out3.dat; echo "RC: $?"; rm -f out3.dat ; \
   done ) & 
done
wait
t2=`date +%s`
let dt=$t2-$t1

echo "elaped: ${dt}"
let bps=6*3*${nmax}*${fsize}/${dt}/1000000
echo "MiBps: ${bps}"

date

echo "========= Start detailed log ======="
for ((i=0; $i<${nmax}; i=$i+1)); do cat subdir_$i/out?.log; done
echo "=========  End detailed log  ======="



