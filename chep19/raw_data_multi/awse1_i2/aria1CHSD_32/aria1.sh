#!/bin/bash

let d=$1%2

if [ $d -eq 0 ]; then
  dn=stashcache.t2.ucsd.edu:8000
else
  dn=osg.chic.nrp.internet2.edu:9001
fi

cd /dev/shm
pwd
i=`echo ${_CONDOR_SLOT} | awk '{split($0,a,"slot"); print a[2]}'`
echo Slot ${_CONDOR_SLOT}
echo "Fetching 1G_$i.dat (http://${dn}/user/dweitzel/public/chep/file.cvmfs.1000)"
rm -f 1G_$i.*dat
date
date 1>&2
time aria2c --header='Want-Digest: ' -q -j 80 -x 16 http://${dn}/user/dweitzel/public/chep/file.cvmfs.1000 -o 1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
echo "--- Mid run ---"
echo "--- Mid run ---" 1>&2
date
date 1>&2
time aria2c --header='Want-Digest: ' -q -j 80 -x 16 http://${dn}/user/dweitzel/public/chep/file.cvmfs.1000 -o 1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
echo "=== Mid run end ==="
echo "=== Mid run end ===" 1>&2
date
date 1>&2
time aria2c -q --header='Want-Digest: ' -j 80 -x 16 http://${dn}/user/dweitzel/public/chep/file.cvmfs.1000 -o 1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
date
date 1>&2
time aria2c --header='Want-Digest: ' -q -j 80 -x 16 http://${dn}/user/dweitzel/public/chep/file.cvmfs.1000 -o 1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
date
date 1>&2
time aria2c --header='Want-Digest: ' -q -j 80 -x 16 http://${dn}/user/dweitzel/public/chep/file.cvmfs.1000 -o 1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
date
date 1>&2
time aria2c --header='Want-Digest: ' -q -j 80 -x 16 http://${dn}/user/dweitzel/public/chep/file.cvmfs.1000 -o 1G_$i.dat
echo "RC $?"
ls -l 1G_$i.dat
rm -f 1G_$i.*dat
date
date 1>&2

